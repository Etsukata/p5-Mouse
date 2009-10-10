package MyRole;

use Mouse::Role;

sub foo { return (caller(0))[3] }

no Mouse::Role;

package MyClass1; use Mouse; with 'MyRole'; no Mouse;
package MyClass2; use Mouse; with 'MyRole'; no Mouse;

package main;

use Test::More tests => 4;

{
  local $TODO = 'Role composition does not clone methods yet';
  is(MyClass1->foo, 'MyClass1::foo',
    'method from role has correct name in caller()');
  is(MyClass2->foo, 'MyClass2::foo',
    'method from role has correct name in caller()');
}

isnt(MyClass1->foo, "MyClass2::foo", "role method is not confused with other class" );
isnt(MyClass2->foo, "MyClass1::foo", "role method is not confused with other class" );
