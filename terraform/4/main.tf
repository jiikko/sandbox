// https://gist.github.com/mgoldchild/c1d7cb54bdfcc67340565e30db89d702

data "aws_iam_policy_document" "allow_describe_regions" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:DescribeRegions"]
    resources = ["*"]
  }
}
// 
// resource "aws_iam_policy" "example" {
//   name   = "example"
//   policy = data.aws_iam_policy_document.allow_describe_regions.json
// }
// 
// // 信頼ポリシー
// data "aws_iam_policy_document" "ec2_assume_role" {
//   statement {
//     actions = ["sts:AccumeRole"]
//     principals {
//       type        = "Service"
//       identifiers = ["ec2.amazonaws.com"]
//     }
//   }
// }
// 
// // IAMロール
// resource "aws_iam_role" "example" {
//   name               = "example"
//   assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
// }
// 
// resource "aws_iam_role_policy_attachment" "example" {
//   role       = aws_iam_role.example.name
//   policy_arn = aws_iam_policy.example.arn
// }



module "describe_regions_for_ec2" {
  source     = "./iam_role"
  name       = "describe-regions-for-ec2"
  identifier = "ec2.amazonaws.com"
  policy     = data.aws_iam_policy_document.allow_describe_regions.json
}
