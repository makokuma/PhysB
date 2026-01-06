program coupled_oscillator
  use params
  use dynamics_decoupled
  use io_mod
  implicit none
  
  real(8), allocatable :: rx(:), ry(:)
  real(8), allocatable :: vx(:), vy(:)
  real(8), allocatable :: ax(:), ay(:)

  real(8) :: t

  integer, parameter :: nskip = 100
  integer :: step, out_unit, i
  integer :: ipos

  call read_params()

  allocate(rx(N), ry(N), vx(N), vy(N), ax(N), ay(N))

  do i = 1, N
    rx(i) = (i-1) * l0
    ry(i) = 0.0d0
  end do

  vx = 0.0d0
  vy = 0.0d0

  ipos = int(pos_frac * (N-1)) + 1
  if (ipos < 1) ipos = 1
  if (ipos > N) ipos = N

  select case (trim(init_type))

  case ("pluck_y")
    ry(ipos) = amp

  case ("pluck_x")
    rx(ipos) = rx(ipos) + amp

  case ("pluck_xy")
    rx(ipos) = rx(ipos) + amp
    ry(ipos) = amp

  case ("none")
    ! 何もしない

  case default
    write(*,*) "Unknown init_type =", trim(init_type)
    stop

  end select

  rx(1) = 0.0d0
  ry(1) = 0.0d0
  rx(N) = (N-1) * l0
  ry(N) = 0.0d0

  ! initial condition (example)
!  x = 0.0d0
!  x(N/2) = 0.1d0
!  v = 0.0d0

  call compute_acceleration_2d(rx, ry, ax, ay, N, kx, ky, m)


  call open_output(out_unit)
  t = 0.0d0
  call write_output(out_unit, t, rx, ry)

  ! 初期加速度
!  call compute_acceleration(x, a, N, k, m)

  do step = 1, nstep

    ! --- 1. 速度を半ステップ進める ---
!    v = v + 0.5d0 * a * dt

    ! --- 2. 位置を1ステップ進める ---
!    x = x + v * dt

    ! --- 固定端条件 ---
!    x(1) = 0.0d0
!    x(N) = 0.0d0


    vx = vx + 0.5d0 * ax * dt
    vy = vy + 0.5d0 * ay * dt

    rx = rx + vx * dt
    ry = ry + vy * dt

    rx(1) = 0.0d0
    ry(1) = 0.0d0
    rx(N) = (N-1) * l0
    ry(N) = 0.0d0

    call compute_acceleration_2d(rx, ry, ax, ay, N, kx, ky, m)

    vx = vx + 0.5d0 * ax * dt
    vy = vy + 0.5d0 * ay * dt


    vx(1) = 0.0d0
    vy(1) = 0.0d0
    vx(N) = 0.0d0
    vy(N) = 0.0d0
    ! --- 3. 新しい加速度 ---
!    call compute_acceleration(x, a, N, k, m)

    ! --- 4. 速度をもう半ステップ ---
!    v = v + 0.5d0 * a * dt

    ! --- 固定端条件 ---
!    v(1) = 0.0d0
!    v(N) = 0.0d0

    t = t + dt

    if (mod(step, output_interval) == 0) then
      call write_output(out_unit, t, rx, ry)
    endif

  end do


  close(out_unit)
end program coupled_oscillator

