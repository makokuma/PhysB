program coupled_oscillator
  use params
  use dynamics
  use io_mod
  implicit none

  real(8), allocatable :: x(:), v(:), a(:)
  real(8) :: t
  integer :: step, out_unit

  call read_params()

  allocate(x(N), v(N), a(N))

  ! initial condition (example)
  x = 0.0d0
  x(N/2) = 0.1d0
  v = 0.0d0

  call compute_acceleration(x, a, N, k, m)

  call open_output(out_unit)
  t = 0.0d0
  call write_output(out_unit, t, x)

  do step = 1, nstep
    ! --- Velocity Verlet ---
    x = x + v*dt + 0.5d0*a*dt*dt
    v = v + 0.5d0*a*dt

    call compute_acceleration(x, a, N, k, m)

    v = v + 0.5d0*a*dt
    t = t + dt

    if (mod(step, output_interval) == 0) then
      call write_output(out_unit, t, x)
    end if
  end do

  close(out_unit)
end program coupled_oscillator

