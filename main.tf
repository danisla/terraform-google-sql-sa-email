# Copyright 2017 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

data "external" "sa_email" {
  program = ["${path.module}/get_sa_email.sh"]

  query {
    instance = "${var.instance}"
    project  = "${var.project}"
  }
}

locals {
  sa_email = "${lookup(data.external.sa_email.result, "sa_email")}"
  instance = "${lookup(data.external.sa_email.result, "instance")}"
  project  = "${lookup(data.external.sa_email.result, "project")}"
}
