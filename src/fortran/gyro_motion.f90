module condition
    implicit none
    integer, parameter :: N = 100000, epoch = 1000
    double precision, parameter :: dt = 0.001d0
    double precision, parameter :: m = 1.d0
    double precision, parameter :: c = 1.d0, e = -1.d0
    ! E//B用 ==========================================
    double precision, parameter :: bf0 = 1.d0, ef0 = 0.005
    double precision, dimension(3), parameter :: bf = (/ 0.d0, 0.d0, bf0/), ef = (/ 0.d0, 0.d0, ef0/)
    ! ExB用 ==========================================
    ! double precision, parameter :: bf0 = 1.d0, ef0 = 0.1d0
    ! double precision, dimension(3), parameter :: bf = (/ 0.d0, 0.d0, bf0/), ef = (/ 0.d0, ef0, 0.d0/)

    contains

    function rkfd(v)
        double precision rkfd(3)
        double precision, dimension(3), intent(in) :: v

        rkfd(1) = e/m*(ef(1) + (v(2)*bf(3) - v(3)*bf(2)))
        rkfd(2) = e/m*(ef(2) + (v(3)*bf(1) - v(1)*bf(3)))
        rkfd(3) = e/m*(ef(3) + (v(1)*bf(2) - v(2)*bf(1)))

    end
end


subroutine rk4(v)
    use condition
    implicit none 
    double precision, dimension(3), intent(inout) :: v
    double precision :: tmp(3), k(4, 3)

    tmp(:) = v(:)
    k(1, :) = dt*rkfd(tmp)

    tmp(:) = v(:) + k(1, :)*0.5d0
    k(2, :) = dt*rkfd(tmp)

    tmp(:) = v(:) + k(2, :)*0.5d0
    k(3, :) = dt*rkfd(tmp)

    tmp(:) = v(:) + k(3, :)
    k(4, :) = dt*rkfd(tmp)

    v(:) = v(:) + (k(1, :) + 2.*k(2, :) + 2.*k(3, :) + k(4, :))/6.

end subroutine rk4


subroutine del_spaces(s)
    character (*), intent (inout) :: s
    character (len=len(s)) tmp
    integer i, j
    j = 1
    do i = 1, len(s)
        if (s(i:i)==' ') cycle
        tmp(j:j) = s(i:i)
        j = j + 1
    end do
    s = tmp(1:j-1)
end subroutine del_spaces


program main
    use condition
    double precision :: t0, t1
    double precision :: r(3), v(3)
    ! character linebuf*256

    r(1) = 1.d0
    r(2:3) = 0.d0

    v(1) = 0.d0
    v(2) = 1.d0
    v(3) = 0.d0

    ! open(10, file='gyro_motion_EperpB_f90.dat')

    call cpu_time(t0)
    do i = 1, N
        call rk4(v)
        r(:) = r(:) + dt*v(:)
    !     if (mod(i, epoch) .eq. 0) then
    !         write (linebuf, *) r(1), ',', r(2), ',', r(3), ',', v(1), ',', v(2), ',', v(3) ! 一旦内部ファイルへ書き出す
    !         call del_spaces(linebuf)           ! 余分な空白を削除する
    !         write (10, '(a)') trim(linebuf)    ! 出力する
    !     endif
    enddo
    call cpu_time(t1)

    print *, t1 - t0

    ! close(10)
    ! print *, rkfd(v)

end
