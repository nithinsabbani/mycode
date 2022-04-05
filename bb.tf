variable "elb"{
}
resource aws_ebs_volume "ebs"{
size=var.elb
avaliability_zone="ap-southeast-1a"
type="gp2"
}
