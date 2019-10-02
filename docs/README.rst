.. _readme:

apt-cacher-formula
==================

|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/apt-cacher-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/apt-cacher-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

A SaltStack formula that is empty. It has dummy content to help with a quick
start on a new formula and it serves as a style guide.

.. contents:: **Table of Contents**

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_.

If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``,
which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.

See `Formula Versioning Section <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

Contributing to this repo
-------------------------

**Commit message formatting is significant!!**

Please see :ref:`How to contribute <CONTRIBUTING>` for more details.

Available states
----------------

.. contents::
   :local:

``apt-cacher.server``
^^^^^^^^^^^^^^^^^^^^^

Installs the apt-cacher package.

``apt-cacher.client``
^^^^^^^^^^^^^^^^^^^^^

Sets up the system to use the apt-cacher server as the caching proxy.

``apt-cacher.ng.server``
^^^^^^^^^^^^^^^^^^^^^^^^

Install and configure apt-cacher-ng.

Supports Debian(ish) distributions and FreeBSD.

``apt-cacher.ng.server.package``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Installs the apt-cacher-ng package.

``apt-cacher.ng.server.config``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Installs the apt-cacher-ng config.

``apt-cacher.ng.server.service``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Manages the startup and running state of the apt-cacher-ng service.

``apt-cacher.ng.client``
^^^^^^^^^^^^^^^^^^^^^^^^

Sets up the system to use the apt-cacher-ng server as the caching proxy.

Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^^^^^

Creates the docker instance and runs the ``apt-cacher`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^^^^^

Removes the docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.
