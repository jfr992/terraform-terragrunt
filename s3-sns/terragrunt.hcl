include "root" {
  path = find_in_parent_folders()
}

inputs = {
 bucket-name = "s3-test-sns-tg"
 email = "juanfelipereyesmarles@gmail.com"
}