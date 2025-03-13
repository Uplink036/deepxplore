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
num_iterations_per_seeds=20 #20
threshold=0 #0

set -o pipefail

echo "| Desired Coverage | Time(s) | Contradictions | "
echo "| ---------------- | ------- | -------------- | "

cd MNIST
mkdir -p generated_inputs/
mkdir -p saved_inputs/
coverage=(0.90 0.95 0.96 0.97); 
for c in ${coverage[@]}; do
    time_str=$( { time python2.7 gen_diff_per.py \
        $transformation \
        $weight_diff \
        $weight_nc \
        $step \
        $num_iterations_per_seeds \
        $threshold  \
        $c; \
        } 2>&1 | awk '/real/{print $2}' )
    seconds=$(convert_to_seconds $time_str)
    contradictions=$(ls generated_inputs -l | wc -l)
    mv generated_inputs/*.png saved_inputs/
    echo "| $c | $seconds | $contradictions |"
done
