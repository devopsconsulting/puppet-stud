puppet-stud: create cluster of ssl offloaders
=============================================

puppet-stud requires the `bfg fork <https://github.com/bfg/stud>`_ of stud. This
fork makes stud configurable through a configuration file. Some of studs options
where allready configurable through a config file but not as finegrained as the
bfg fork.

Puppet-stud can do 2 types of installations, either with shared ssl sessions or
without. We would never need shared sessions for websockets for example because
there is a single connection that stays up.

usage for a server with shared sessions::

    $peers = [{
        fqdn => 'stud1.example.com'
    }, {
        fqdn => 'stud2.example.com'
    }]
    
    class{"stud":
        backend_ip => '172.31.8.100',
        backend_port => 80,
        frontend_port => 443,
        peers => $peers,
    }

If you are using :ref:`puppet-kicker` you can also get the peers as follows::

    # assuming your stud peers are assigned the role 'stud'
    class{"stud":
        backend_ip => '172.31.8.100',
        backend_port => 80,
        frontend_port => 443,
        peers => servers_with_role('stud'),
    }

Just leave out the pears param to disable it. Stud also supports
`the proxy protocol <http://haproxy.1wt.eu/download/1.5/doc/proxy-protocol.txt>`_
wich can also be enabled if used with a haproxy backend::

    class{"stud":
        backend_ip => '172.31.8.42',
        backend_port => 8081,
        frontend_port => 443,
        proxy => true,
    }

The parameters puppet-stud accepts are:

- ``frontend_port``: The port stud is listening on.
- ``backend_ip``: The ip of the backend service.
- ``backend_port``: The port the backend service is listening on.
- ``peers``: If ssl sessions should be shared across stud instances, set to an array of peers.
- ``proxy``: If stud should add proxy headers (haproxy in accept-proxy mode), set to true.
