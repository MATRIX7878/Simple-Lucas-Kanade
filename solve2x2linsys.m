function [deltau] = solve2x2linsys(Z,err)

%Basic function that does essentially the same thing as A\B
det = Z(1,1)*Z(2,2)-Z(1,2)*Z(2,1);
deltau(1)=(Z(2,2)*err(1)-Z(2,1)*err(2))/det;
deltau(2)=(Z(1,1)*err(2)-Z(1,2)*err(1))/det;

end

