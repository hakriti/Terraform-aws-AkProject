resource "aws_key_pair" "egprojectkey" {
  key_name   = "egprojectkey"
  public_key = file(var.PUB_KEY_PATH)
}
