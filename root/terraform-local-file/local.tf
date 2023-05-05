resource "local_file" "pet" {
  filename = "${path.module}/pets.txt"
  content = "We love pets!"
}