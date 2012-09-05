
# configure stud, write a config file and install certificate.
class stud::config($frontend_port, $backend_ip, $backend_port, $peers, $proxy) {

    # write stud config file. Note that this config file syntax is
    # not yet merged into stud HEAD. use bfg fork instead!
    file {"/etc/stud/stud.conf":
        content => template("stud/stud.conf.erb"),
        require => Class["stud::install"],
        notify => Class["stud::service"],
        ensure => file,
    }
    
    # install certificate. (It's fake dummy cert).
    file{"/etc/stud/cert.pem":
        owner => "root",
        group => "root",
        mode => 0440,
        source => "puppet:///modules/stud/cert.pem",
    }
    
    # register with lvs.
    notify {"kick -> lvs":}
}