/* サービス用ロール定義 */

resource "aws_iam_role" "role" {
  name               = "${var.name}"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = "${var.principals}"
    }

    actions = [
      "sts:AssumeRole",
    ]
  }
}
