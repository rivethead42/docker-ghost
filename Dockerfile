# This Dockerfile is used to build a ghost blog image for linuxacademy.com.

FROM rivethead42/ubuntu-base

MAINTAINER Travis N. Thomsen <travis.@linuxacademy.com>
RUN apt-get install lsb-release -y
# Add Puppetfile
COPY puppet/Puppetfile /etc/puppetlabs/puppet/


COPY puppet/hiera/common.json /etc/puppetlabs/code/hieradata/

# Run r10k
RUN PUPPETFILE=/etc/puppetlabs/puppet/Puppetfile PUPPETFILE_DIR=/etc/puppetlabs/code/modules/ r10k puppetfile install --verbose debug2 --color

# Run Puppet apply
#RUN /opt/puppetlabs/bin/puppet apply /etc/puppetlabs/puppet/manifests/site.pp --modulepath=/etc/puppetlabs/code/modules/ --hiera_config /etc/puppetlabs/puppet/hiera.yaml --verbose

#EXPOSE 2368
#CMD ["npm", "start"]
