module params
  implicit none
  integer :: N
  real(8) :: k, m
  real(8) :: dt
  integer :: nstep, output_interval

  namelist /physics/  N, k, m
  namelist /numerics/ dt, nstep, output_interval

contains

  subroutine read_params()
    integer :: ios

    ! default values
    N = 30
    k = 1.0d0
    m = 1.0d0
    dt = 1.0d-3
    nstep = 1000
    output_interval = 10

    open(10, file="input.nml", status="old", action="read", iostat=ios)
    if (ios /= 0) stop "cannot open input.nml"

    read(10, nml=physics)
    read(10, nml=numerics)
    close(10)
  end subroutine read_params

end module params

