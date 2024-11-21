echo "input region name:"
read REGION_NAME

echo "eks cluster name:"
read CLUSTER_NAME

echo "REGION_NAME: $REGION_NAME CLUSTER_NAME: $CLUSTER_NAME"

aws eks update-kubeconfig \
	--region $REGION_NAME \
	--name $CLUSTER_NAME 

