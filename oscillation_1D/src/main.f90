program coupled_oscillator
  use params
  use dynamics
  use io_mod
  implicit none

  real(8), allocatable :: x(:), v(:), a(:)
  real(8) :: t
  integer :: step, out_unit
  integer, parameter :: nskip = 100

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

  ! 初期加速度
  call compute_acceleration(x, a, N, k, m)

  do step = 1, nstep

    ! --- 1. 速度を半ステップ進める ---
    v = v + 0.5d0 * a * dt

    ! --- 2. 位置を1ステップ進める ---
    x = x + v * dt

    ! --- 固定端条件 ---
    x(1) = 0.0d0
    x(N) = 0.0d0

    ! --- 3. 新しい加速度 ---
    call compute_acceleration(x, a, N, k, m)

    ! --- 4. 速度をもう半ステップ ---
    v = v + 0.5d0 * a * dt

    ! --- 固定端条件 ---
    v(1) = 0.0d0
    v(N) = 0.0d0

    t = t + dt

    if (mod(step, nskip) == 0) then
      call write_output(out_unit, t, x)
    endif

  end do


  close(out_unit)
end program coupled_oscillator

