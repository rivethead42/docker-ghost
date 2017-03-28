# This Dockerfile is used to build a ghost blog image for linuxacademy.com.

FROM rivethead42/ubuntu-base

MAINTAINER Travis N. Thomsen <travis.@linuxacademy.com>

# Create hiera data directory
RUN mkdir -p /etc/puppet/hieradata

# Configure manifests and modules
COPY puppet/site.pp /etc/puppet/manifests/

# Add Puppetfile
COPY puppet/Puppetfile /etc/puppet/

# Configure hiera
COPY puppet/hiera/hiera.yaml /etc/puppet/

COPY puppet/hiera/common.json /etc/puppet/hieradata/

# Run r10k
RUN PUPPETFILE=/etc/puppet/Puppetfile PUPPETFILE_DIR=/etc/puppet/modules/ r10k puppetfile install --verbose debug2 --color

# Run Puppet apply
#RUN puppet apply --modulepath=/etc/puppet/modules/ --hiera_config /etc/puppet/hiera.yaml --verbose
