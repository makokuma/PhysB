module params
  implicit none
  public

  integer :: N
  real(8) :: k, kx, ky, m
  real(8) :: dt
  real(8) :: l0
  integer :: nstep, output_interval

  !for init setting

  character(len=16) :: init_type = "none"
  real(8) :: amp = 0.0d0
  real(8) :: pos_frac = 0.5d0

  namelist /physics/  N, k, kx, ky, m, l0
  namelist /numerics/ dt, nstep, output_interval
  namelist /init/     init_type, amp, pos_frac

!  namelist /physics/  N, k, m, l0
!  namelist /numerics/ dt, nstep, output_interval

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
    read(10, nml=init)
    close(10)
  end subroutine read_params

end module params

