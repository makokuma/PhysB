module dynamics_decoupled
  implicit none
contains

  subroutine compute_acceleration_2d(rx, ry, ax, ay, N, kx, ky, m)
    integer, intent(in) :: N
    real(8), intent(in)  :: rx(N), ry(N)
    real(8), intent(out) :: ax(N), ay(N)
    real(8), intent(in)  :: kx, ky, m
    integer :: j

    ax = 0.0d0
    ay = 0.0d0

    do j = 2, N-1
      ax(j) = (kx/m) * ( rx(j+1) - 2.0d0*rx(j) + rx(j-1) )
      ay(j) = (ky/m) * ( ry(j+1) - 2.0d0*ry(j) + ry(j-1) )
    end do

    ax(1) = 0.0d0
    ay(1) = 0.0d0
    ax(N) = 0.0d0
    ay(N) = 0.0d0

  end subroutine compute_acceleration_2d

end module dynamics_decoupled

