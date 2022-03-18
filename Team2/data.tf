data "terraform_remote_state" "main" {
	backend = "s3"
        config = {
            bucket = "remote-state-bucket1"
            key    = "path/to/my/key"
            region = "us-east-1"
	}
}

output "full_list" {
	value = data.terraform_remote_state.main.outputs.*
}




resource "aws_s3_bucket" "test" {
    name = "remote-state-bucket1"
}