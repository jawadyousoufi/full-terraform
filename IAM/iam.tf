resource "aws_iam_user" "lb" {
  name = "loadbalancer"
}

resource "aws_iam_user" "multiuser" {
  name = each.key
  for_each = toset([
    "bob",
    "sam",
    "lisa",
  ])
}



resource "aws_iam_group" "octobergroup" {
  name = "octobergroup"
}

resource "aws_iam_group_membership" "developers_team" {
  name  = "developers-group-membership"
  users = [aws_iam_user.lb.name]
  group = aws_iam_group.octobergroup.name
}
