# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


locals {
  comp_instances = {
          inst1-Python = {
              ad                          = null                                                                                  #0-AD1, 1-AD2, 3-AD3 Required
              compartment_id              = null #"ocid1.xxxxx" #Optional if var.default_compartment_id set
              shape                       = "VM.Standard2.1"                                                                      #Required
              subnet_id                   = "ocid1.xxxxx"   #Required

              is_monitoring_disabled      = null

              assign_public_ip            = true
              vnic_defined_tags           = null
              vnic_display_name           = null
              vnic_freeform_tags          = null
              nsg_ids                     = null  
              private_ip                  = null
              skip_src_dest_check         = null

              defined_tags                = null
              display_name                = null
              extended_metadata           = null
              fault_domain                = null
              freeform_tags               = null
              hostname_label              = null
              ipxe_script                 = null
              pv_encr_trans_enabled       = null

              ssh_authorized_keys         = ["</path/public key file>"]     #ex: ["/path/public-key.pub"]
              ssh_private_keys            = ["</path/private key file>"]    #ex: ["/path/private-key"]
              bastion_ip                  = null
              user_data                   = base64encode(file("bootstrap.sh"))

              // See https://docs.cloud.oracle.com/iaas/images/
              // Oracle-provided image "Oracle-Linux-7.7-2019.10.19-0"
              image_name             = "Oracle-Linux-7.7-2019.10.19-0" #Required
              source_id                   = null #"ocid1.xxxxx"  #Required
              source_type                 = null
              boot_vol_size_gbs           = null
              kms_key_id                  = null

              preserve_boot_volume        = null
              instance_timeout            = null
              sec_vnics                   = null
              mount_blk_vols              = null
              block_volumes               = null
              cons_conn_create            = null
              cons_conn_def_tags          = null
              cons_conn_free_tags         = null
              mkp_image_name              = null
              mkp_image_name_version      = null
          }, 
          "inst2-Apache" = {
              ad                           = 0                                                                                     #0-AD1, 1-AD2, 3-AD3 Required
              compartment_id              = null #"ocid1.xxxxx" #Optional if var.default_compartment_id set
              shape                       = "VM.Standard2.1"                                                                      #Required

              is_monitoring_disabled      = null

              subnet_id                   = "ocid1.xxxxx"   #Required
              assign_public_ip            = true
              vnic_defined_tags           = null
              vnic_display_name           = "VNICName"
              vnic_freeform_tags          = null
              nsg_ids                     = null # ["ocid1.xxxxx"] Required to access
              private_ip                  = null  #"10.0.3.8"
              skip_src_dest_check               = null

              defined_tags                = null
              display_name                = "SimpleInstance2"
              extended_metadata           = null
              fault_domain                = null  #"FAULT-DOMAIN-1"
              freeform_tags               = null
              hostname_label              = null  #"HostLabel"
              ipxe_script                 = null
              pv_encr_trans_enabled       = null

              ssh_authorized_keys         = ["</path/public key file>"]     #ex: ["/path/public-key.pub"]
              ssh_private_keys            = ["</path/private key file>"]    #ex: ["/path/private-key"]
              user_data                   = base64encode(file("bootstrap-Apache.sh"))
              bastion_ip                  = null

              // See https://docs.cloud.oracle.com/iaas/images/
              // Oracle-provided image "Oracle-Linux-7.7-2019.10.19-0"
              image_name             = "Oracle-Linux-7.7-2019.10.19-0" #Required
              source_id                   = null #"ocid1.image.oc1.iad.aaaaaaaay66pu7z27ltbx2uuatzgfywzixbp34wx7xoze52pk33psz47vlfa"  #Required
              mkp_image_name              = null
              mkp_image_name_version      = null
              source_type                 = null
              boot_vol_size_gbs           = 60
              kms_key_id                  = null

              preserve_boot_volume        = null
              instance_timeout            = "25m"
              sec_vnics                   = null
              mount_blk_vols              = null
              block_volumes               = null
              cons_conn_create            = null
              cons_conn_def_tags          = null
              cons_conn_free_tags         = null
          }
  }
}


module "oci_instances" {
  source                  = "../../"
  
  default_compartment_id  = var.default_compartment_id
  instances               = local.comp_instances

}