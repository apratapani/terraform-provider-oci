resource "oci_core_instance" "TFInstance" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "NFS server"
  hostname_label      = "NFSserver"
  image               = "${var.InstanceImageOCID[var.region]}"
  shape               = "${var.InstanceShape}"
  subnet_id           = "${oci_core_subnet.ExampleSubnet.id}"

  metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"
    user_data           = "${base64encode(file(var.BootStrapFile))}"
  }

  timeouts {
    create = "60m"
  }
}
