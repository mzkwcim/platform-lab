locals {
  worker_file_path = "${path.root}/index.js"
  worker_file_name = basename(local.worker_file_path)

}