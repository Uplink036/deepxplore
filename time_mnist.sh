transformation=light
weight_diff=1
weight_nc=0.1
step=10 
num_input_seeds=500
num_iterations_per_seeds=5 #20
threshold=0

cd MNIST
time python2.7 gen_diff.py \
    $transformation \
    $weight_diff \
    $weight_nc \
    $step \
    $num_input_seeds \
    $num_iterations_per_seeds \
    $threshold 

contradictions=$(ls generated_inputs -l | wc -l)
echo You found $contradictions contradictions.
mkdir -p saved_inputs/
mv generated_inputs/*.png saved_inputs/
