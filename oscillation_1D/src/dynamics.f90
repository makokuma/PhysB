module dynamics
  implicit none
contains

  subroutine compute_acceleration(x, a, N, k, m)
    integer, intent(in) :: N
    real(8), intent(in)  :: x(N)
    real(8), intent(out) :: a(N)
    real(8), intent(in)  :: k, m
    integer :: i

    a = 0.0d0

    ! interior points
    do i = 2, N-1
      a(i) = (k/m) * (x(i+1) - 2.0d0*x(i) + x(i-1))
    end do

    ! TODO: 境界条件を自分で書く
    a(1) = 0.0d0
    a(N) = 0.0d0

  end subroutine compute_acceleration

end module dynamics

