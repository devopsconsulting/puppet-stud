
# install and configure a stud ssl offloader.
# params:
#    frontend_port: The port stud is listening on.
#    backend_ip: The ip of the backend service.
#    backend_port: The port the backend service is listening on.
#    peers: If ssl sessions should be shared across stud instances, add a list of peers.
#    proxy: If stud should add proxy headers (haproxy in accept-proxy mode), set to true.
class stud ($frontend_port, $backend_ip, $backend_port, $peers=[], $proxy=false) {
    include stud::install
    class {"stud::config":
        frontend_port => $frontend_port,
        backend_ip => $backend_ip,
        backend_port => $backend_port,
        peers => $peers,
        proxy => $proxy,
    }
    include stud::service
    
    Class["stud::install"] -> Class["stud::config"] -> Class["stud::service"]
}