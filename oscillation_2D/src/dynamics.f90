module dynamics
  implicit none
contains

  subroutine compute_acceleration_2d(rx, ry, ax, ay, N, k, m, l0)
    integer, intent(in) :: N
    real(8), intent(in)  :: rx(N),ry(N)
    real(8), intent(out) :: ax(N), ay(N)
    real(8), intent(in)  :: k, m, l0
    integer :: i
    real(8) :: dx, dy, r, dr
    real(8) :: fx, fy

    ax = 0.0d0
    ay = 0.0d0

    ! interior points
    do i = 1, N-1
      dx = rx(i+1) - rx(i)
      dy = ry(i+1) - ry(i)

      r = sqrt(dx*dx + dy*dy)
      if (r == 0.0d0) cycle

      dr = r - l0

      fx = k * dr * dx / r
      fy = k * dr * dy / r

      ax(i)   = ax(i)   + fx / m
      ay(i)   = ay(i)   + fy / m
      ax(i+1) = ax(i+1) - fx / m
      ay(i+1) = ay(i+1) - fy / m


    end do

    !加速度の一時的なゼロ(横波確認用）
    ax(1:N)=0._8
  end subroutine compute_acceleration_2d

end module dynamics
