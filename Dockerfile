# This Dockerfile is used to build a ghost blog image for linuxacademy.com.

FROM rivethead42/ubuntu-base

MAINTAINER Travis N. Thomsen <travis.@linuxacademy.com>

ENV GHOST_CONTENT /var/lib/ghost
ENV GHOST_CONTENT /var/lib/ghost

RUN apt-get install lsb-release -y
# Add Puppetfile
#COPY puppet/Puppetfile /etc/puppet/
COPY puppet/Puppetfile /etc/puppet/


#COPY puppet/hiera/common.json /etc/puppet/hieradata/
COPY puppet/hiera/common.json /etc/puppet/hieradata/

# Run r10k
RUN PUPPETFILE=/etc/puppet/Puppetfile PUPPETFILE_DIR=/etc/puppet/modules/ r10k puppetfile install --verbose debug2 --color

# Run Puppet apply
#RUN /opt/puppetlabs/bin/puppet apply /etc/puppet/manifests/site.pp --modulepath=/etc/puppet/modules/ --hiera_config /etc/puppet/hiera.yaml --verbose
RUN puppet apply /etc/puppet/manifests/site.pp --modulepath=/etc/puppet/modules/ --hiera_config /etc/puppet/hiera.yaml --verbose

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

VOLUME /var/lib/ghost

EXPOSE 2368
CMD ["npm", "start"]
