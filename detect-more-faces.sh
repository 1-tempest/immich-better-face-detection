#!/bin/sh

# Get the mount source for the target /cache in the immich_machine_learning container
container_name="immich_machine_learning"

# Variables that shouldn't need to be changed
new_model_url="https://huggingface.co/immich-app/scrfd_34g_gnkps/resolve/main/detection/model.onnx?download=true"
target_path="/cache"
model_path="/facial-recognition/buffalo_l/detection/"
model_name="model.onnx"
updated_flag=".updated_model"
DEBUG="false"

debug_echo() {
  if [ "$DEBUG" = "true" ]; then
    echo "$1"
  fi
}

# Use the source volume to find the mount point
source_volume=$(docker inspect "$container_name" | grep -A 5 '"Mounts":' | grep -B 5 '/cache' | grep '"Source":' | sed 's/.*"Source": "\(.*\)".*/\1/')


debug_echo "Source Volume: $source_volume"

if [ -z "$source_volume" ]; then
  echo "Volume not Found"
  echo "You may need to run the immich_machine_learning container first."
  echo "Exiting..."
  exit 1
fi

if docker exec $container_name test -f "${target_path}${model_path}${updated_flag}"; then
  echo "Updated model already exists in the container."
  echo "Replacing again in..."
  for i in 10 9 8 7 6 5 4 3 2 1; do
    echo "$i..."
    sleep 1
  done
fi

if docker exec $container_name test -f "${target_path}${model_path}${model_name}"; then
  debug_echo "Model exists in the container."
else
  echo "Model not found in the container."
  echo "You may need to run a facial detection job first before updating the model."
  echo "Exiting..."
  exit 1
fi

# Update the model
echo "Updating model..."

# Download the model using curl
curl -L "$new_model_url" -o "$model_name"

# Check if the download was not successful
if [ ! -f "$model_name" ]; then
  echo "Failed to download the model or the file does not exist."
  echo "Exiting..."
  exit 1
fi

# Copy the model to the container
docker cp $model_name $container_name:$target_path$model_path

# delete the downloaded model
rm "$model_name"

# Create the .updated_model file to indicate the model has been updated
docker exec $container_name touch "${target_path}${model_path}${updated_flag}"
echo "Model updated successfully."