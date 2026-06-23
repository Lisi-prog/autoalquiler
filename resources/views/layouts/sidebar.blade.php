<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion toggled" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="{{url('/')}}">
        <div class="sidebar-brand-icon">
            <i class="fas fa-car"></i>
        </div>
        <div class="sidebar-brand-text mx-3">AutoGest</div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- Nav Item - Dashboard -->
    <li class="nav-item active">
        <a class="nav-link" href="{{url('/')}}">
            <i class="fas fa-home"></i>
            <span>Inicio</span></a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    {{-- <div class="sidebar-heading">
        Gerente
    </div> --}}

    <!-- Nav Item - Pages Collapse Menu -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="{{route('sucursal.index')}}"
            aria-expanded="true" aria-controls="collapseTwo">
            <i class="fas fa-store"></i>
            <span>Sucursal</span>
        </a>
    </li>

    <li class="nav-item">
        <a class="nav-link collapsed" href="{{route('vehiculo.index')}}"
            aria-expanded="true" aria-controls="collapseTwo">
            <i class="fas fa-car-side"></i>
            <span>Vehiculo</span>
        </a>
    </li>

    <li class="nav-item">
        <a class="nav-link collapsed" href="{{route('reserva.index')}}"
            aria-expanded="true" aria-controls="collapseTwo">
            <i class="fas fa-clipboard-list"></i>
            <span>Reserva</span>
        </a>
    </li>

    <li class="nav-item">
        <a class="nav-link collapsed" href="#"
            aria-expanded="true" aria-controls="collapseTwo">
            <i class="fas fa-clipboard-check"></i>
            <span>Alquileres</span>
        </a>
    </li>
    
    
    {{-- <div class="btn-group dropright">
            <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                Dropright
            </button>
            <div class="dropdown-menu">
                <button class="dropdown-item" type="button">Action</button>
                <button class="dropdown-item" type="button">Another action</button>
                <button class="dropdown-item" type="button">Something else here</button>
            </div>
    </div> --}}

    <!-- Nav Item - Utilities Collapse Menu -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
            aria-expanded="true" aria-controls="collapseUtilities">
            <i class="fas fa-history"></i>
            <span>Logs</span>
        </a>
        <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
            data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">Logs:</h6>
                <a class="collapse-item" href="{{route('logs.alquiler')}}">Alquiler</a>
                <a class="collapse-item" href="{{route('logs.alquiler.estado')}}">Alquiler Estado</a>
                <a class="collapse-item" href="{{route('logs.detalle.factura')}}">Detalle Factura</a>
                <a class="collapse-item" href="{{route('logs.factura')}}">Factura</a>
                <a class="collapse-item" href="{{route('logs.mantenimiento')}}">Mantenimiento</a>
                <a class="collapse-item" href="{{route('logs.reserva')}}">Reserva</a>
                <a class="collapse-item" href="{{route('logs.reserva.estado')}}">Reserva Estado</a>
                <a class="collapse-item" href="{{route('logs.sucursal')}}">Sucursal</a>
                <a class="collapse-item" href="{{route('logs.taller')}}">Taller</a>
                <a class="collapse-item" href="{{route('logs.tarifa')}}">Tarifa</a>
                <a class="collapse-item" href="{{route('logs.tipo.vehiculo')}}">Tipo Vehiculo</a>
                <a class="collapse-item" href="{{route('logs.vehiculo')}}">Vehiculo</a>
                <a class="collapse-item" href="{{route('logs.vehiculo.estado')}}">Vehiculo Estado</a>
            </div>
        </div>
    </li>

    <!-- Divider -->
    {{-- <hr class="sidebar-divider"> --}}

    <!-- Heading -->
    {{-- <div class="sidebar-heading">
        Addons
    </div> --}}

    <!-- Nav Item - Pages Collapse Menu -->
    {{-- <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
            aria-expanded="true" aria-controls="collapsePages">
            <i class="fas fa-fw fa-folder"></i>
            <span>Pages</span>
        </a>
        <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">Login Screens:</h6>
                <a class="collapse-item" href="login.html">Login</a>
                <a class="collapse-item" href="register.html">Register</a>
                <a class="collapse-item" href="forgot-password.html">Forgot Password</a>
                <div class="collapse-divider"></div>
                <h6 class="collapse-header">Other Pages:</h6>
                <a class="collapse-item" href="404.html">404 Page</a>
                <a class="collapse-item" href="blank.html">Blank Page</a>
            </div>
        </div>
    </li> --}}

    <!-- Nav Item - Charts -->
    {{-- <li class="nav-item">
        <a class="nav-link" href="charts.html">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>Charts</span></a>
    </li> --}}

    <!-- Nav Item - Tables -->
    {{-- <li class="nav-item">
        <a class="nav-link" href="tables.html">
            <i class="fas fa-fw fa-table"></i>
            <span>Tables</span></a>
    </li> --}}

    <!-- Divider -->
    {{-- <hr class="sidebar-divider d-none d-md-block"> --}}

    <!-- Sidebar Toggler (Sidebar) -->
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>

</ul>
<!-- End of Sidebar -->