## ec2ssh

Why?

Having to lookup IPs by instance name in the AWS UI or CLI is annoying. This tries to automate it as much as possible, including selecting the right SSH key.

Requirements:

* AWS CLI installed and usable

    * `pip install awscli`
    * "aws configure" needs to be ran and keys setup, or
    * the instance in which this runs needs to be in an IAM role with (at minimum) `"ec2:Describe*"`

* jq (https://stedolan.github.io/jq/)

    * `apt-get install jq`

Notes:

* All instances must be accessible by private IP. If someone wanted to write logic to check private IP, then fall back to public, that would be neat. However, my use case doesn't require it.
* I've tried my best to make it as failsafe as possible. Bash is annoying to deal with though, so there might be edge cases where it still breaks.
