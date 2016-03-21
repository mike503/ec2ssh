# ec2ssh

A simple script to remove the headache of figuring out the instance IP, the right key, etc. Having to lookup IPs by instance name in the AWS UI or CLI is annoying. This tries to automate that as much as possible.

## Requirements

* AWS CLI installed and usable

    * `pip install awscli`
    * `aws configure` needs to be ran to select default region (TODO: add in a sensible default)

* The AWS API needs to be accessible

    * your ~/.aws/credentials or ~/.aws/config needs to have valid keys (created by `aws configure`), OR
    * the instance in which this runs needs to be in an IAM role that has (at minimum) `"ec2:Describe*"`

* jq (https://stedolan.github.io/jq/) for command-line JSON parsing

    * `apt-get install jq`

## Optional requirements

* Bash completion

     * `sudo cp ec2ssh.bash_completion.sh /etc/bash_completion.d/ec2ssh`
     * `source /etc/bash_completion.d/ec2ssh` (or logout and log back in)

## Assumptions

* You're actually leaving the ubuntu or ec2-user accounts alone and the authorized_keys they're supposed to have (I've been guilty of this. Not anymore!)
* Security groups allow the SSH traffic from the source to the destination.
* Peering connections between different VPCs are setup (if applicable.)

## Notes

* This should work inside and outside of a VPC. If the destination is in a VPC, we try the private IP, otherwise it will fall back to the public IP.
* Tries to determine which user to use based on AMI information (and a little hardcoded hint)
* I've tried my best to make it as failsafe as I can. Bash scripting is annoying, so there might be edge cases where it still breaks
* A major caveat currently is each tab completion request is an API hit (investigating a microcaching solution)
* Currently only supports the default region the "aws" CLI tool uses. Will add a region parameter and possibly the ability to search multiple regions (stretch goal)

## TODO

* Add in some microcaching. Easiest to use a flatfile like /tmp/ec2ssh.$username.$minute and a glob remove to remove old files?
* If there are multiple instance matches, we could prompt the user for which to connect to
* If the user leaves a fragment, prompt for the possible options (this would be neat)
* Add in a sensible default region (check ~/.aws/config first, then AWS_ environment var, if neither exist, then us-east-1 it)
* Support multiple region search, or at least add in a region parameter (-r?) to override the default region
