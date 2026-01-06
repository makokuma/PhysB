module io_mod
  implicit none
contains

  subroutine open_output(unit)
    integer, intent(out) :: unit
    unit = 20
    open(unit, file="data/x.dat", status="replace")
    write(unit, '(A)') "# t rx(1)...rx(N)  ry(1)...ry(N)"
  end subroutine open_output

  subroutine write_output(unit, t, rx, ry)
    integer, intent(in) :: unit
    real(8), intent(in) :: t
    real(8), intent(in) :: rx(:), ry(:)

    write(unit, '(F12.6, 1X, *(F12.6), 1X, *(F12.6))') t, rx, ry
  end subroutine write_output

end module io_mod

