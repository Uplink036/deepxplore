LC_NUMERIC=C
convert_to_seconds() {
    local time_str=$1
    local minutes=$(echo $time_str | awk -F'm' '{print $1}')
    local seconds=$(echo $time_str | awk -F'm' '{print $2}' | sed 's/s//')
    echo "$minutes * 60 + $seconds" | bc
}


transformation=light
weight_diff=1
weight_nc=0.1
step=10 
num_input_seeds=100
num_iterations_per_seeds=20 #20
threshold=0
set -o pipefail
mkdir -p saved_inputs/

echo "| Size | Time(s) | Contradictions | "
echo "| ---- | ------- | -------------- | "

cd MNIST
size=(100 200 300 400 500); 
for s in ${size[@]}; do
    time_str=$( { time python2.7 gen_diff.py \
        $transformation \
        $weight_diff \
        $weight_nc \
        $step \
        $s \
        $num_iterations_per_seeds \
        $threshold;  \
        } 2>&1 | awk '/real/{print $2}' )
    seconds=$(convert_to_seconds $time_str)
    contradictions=$(ls generated_inputs -l | wc -l)
    mv generated_inputs/*.png saved_inputs/
    echo "| $s | $seconds | $contradictions |"
done
