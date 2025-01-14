/**
 * Copyright 2024 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  # This label allows for billing report tracking based on module.
  bucket = replace(var.gcs_bucket_path, "gs://", "")
}

resource "random_id" "resource_name_suffix" {
  byte_length = 4
}

# Slurm batch file

data "local_file" "slurm_batch" {
  filename = "${path.module}/train.job"
}
resource "google_storage_bucket_object" "slurm_batch_object" {
  name = "train.job"
  bucket  = local.bucket
  content = data.local_file.slurm_batch.content
}

# Training start script
data "local_file" "train_start" {
  filename = "${path.module}/train.sh"
}
resource "google_storage_bucket_object" "train_start_object" {
  name = "train.sh"
  bucket  = local.bucket
  content = data.local_file.train_start.content
}
