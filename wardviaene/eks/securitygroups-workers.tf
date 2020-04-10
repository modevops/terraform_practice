# workers# workers
resource "aws_security_group" "demo_node" {
  name     = "terraform-eks-demo-node"
  description = "Security group for all nodes in the cluster"
  vpc_id = module.vpc.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"                                      = "terraform-eks-demo-node"
    "kubernetes.io/cluster/${var.cluster-name}" = "owned"
  }

}

resource "aws_security_group_rule" "demo-node-ingress-self" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port = 1025
  protocol = "tcp"
  security_group_id        = aws_security_group.demo-node.id
  source_security_group_id = aws_security_group.demo-cluster.id
  to_port = 65535
  type = "ingress"
}