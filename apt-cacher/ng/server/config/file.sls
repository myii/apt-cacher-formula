# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.ng.server.package.install' %}
{%- from tplroot ~ "/ng/map.jinja" import apt_cacher_ng with context %}
{%- from tplroot ~ "/ng/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

apt-cacher-ng/group/create:
  group.present:
    - name: {{ apt_cacher_ng.group }}

apt-cacher-ng/user/create:
  user.present:
    - name: {{ apt_cacher_ng.user }}

{%- if grains['os_family'] == 'FreeBSD' %}
apt-cacher-ng/user/sysrc:
  sysrc.managed:
    - name: apt_cacher_ng_user
    - value: "{{ apt_cacher_ng.user }}"
{%- endif %}

apt-cacher-ng/config/server_config:
  file.managed:
    - name: {{ apt_cacher_ng.server_config }}
    - user: root
    - group: {{ apt_cacher_ng.root_group }}
    - mode: '644'
    - source: {{ files_switch(['server.conf.tmpl'],
                              lookup='apt-cacher-ng/config/server_config',
                              use_subpath=True
                 )
              }}
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        apt_cacher_ng: {{ apt_cacher_ng | json }}

apt-cacher-ng/config/server_cache_dir:
  file.directory:
    - name: {{ apt_cacher_ng.server_cache_dir }}
    - makedirs: true
    - user: {{ apt_cacher_ng.user }}
    - group: {{ apt_cacher_ng.group }}
    - mode: '2755'

apt-cacher-ng/config/server_log_dir:
  file.directory:
    - name: {{ apt_cacher_ng.server_log_dir }}
    - makedirs: true
    - user: {{ apt_cacher_ng.user }}
    - group: {{ apt_cacher_ng.group }}
    - mode: '2755'

apt-cacher-ng/config/credentials:
  file.managed:
    - name: {{ apt_cacher_ng.credentials }}
    - user: {{ apt_cacher_ng.user }}
    - group: {{ apt_cacher_ng.group }}
    - mode: '600'
    - source: {{ files_switch(['security.conf.tmpl'],
                              lookup='apt-cacher-ng/config/credentials',
                              use_subpath=True
                 )
              }}
    - template: jinja
    - context:
        admin_account: {{ apt_cacher_ng.get('admin_account', False) }}
        admin_passwd: {{ apt_cacher_ng.get('admin_passwd', False) }}
