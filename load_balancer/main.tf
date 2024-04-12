resource "aws_lb" "test" {
  name                       = "test-lb-tf"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.security_group_id]
  subnets                    = var.lb_public_subnet_ids

  tags = {
    Environment = "production"
  }

}

resource "aws_lb_target_group" "test" {
  name = "target"
  port = 80
  # for_each = var.instanece_ids
  # name     = each.key
  # port     = each.value.port
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = var.vpc_id

}


resource "aws_lb_listener" "front_end" {
  for_each = var.instanece_ids
  load_balancer_arn = aws_lb.test.arn
  port              = each.value.port
  protocol          = "HTTP"

  default_action {
    
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}



resource "aws_lb_target_group_attachment" "one" {
  for_each = var.instanece_ids
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = each.value.instanece_id
}