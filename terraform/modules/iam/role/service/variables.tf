/** 変数定義 */

variable "name" {
  description = "ロール名"
}

variable "principals" {
  type        = "list"
  description = "サービスのURLリスト"
}
