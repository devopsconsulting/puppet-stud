
# start the stud service and keep it running.
class stud::service {
    service {"stud":
        ensure => running,
        hasstatus => true,
        hasrestart => true,
        enable => true,
    }
}