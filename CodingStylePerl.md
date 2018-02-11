
This document outlines the required elements of any script, module or application along with the coding style

---

## CODING STYLE ##

---

Broadly speaking it follows the Apache style guide for writing just about anything.

### Indentation and Tabs ###

__Do__ use 2 characters indentation.

__Do NOT__ use tabs. See vimrc options below to convert tabs to spaces.

Here is how to setup your editor to do the right thing.

*vim:*

    .vimrc:
    -------
    " Optional general settings:
    autocmd!              " clears all auto-commands
    set paste             " set the paste option for inserting text
    set nowrap            " do not wrap long lines
    set foldmethod=syntax " fold based on syntax
    set foldcolumn=2      " set the fold column space

    " In order to use filetype options the following must be present
    filetype on
    filetype plugin indent on

    " Explanation of options used below:
    " expandtab replaces any tab keypress with the appropriate number of spaces
    " tabstop=2 sets tabs to 2 spaces
    " shiftwidth=2 
    " softtabstop=2 sets tabs to be spaces
    " showmatch highlights matching braces, use % to jump between matching braces
    " number shows line numbers
    " autoindent does an auto-indent for the next line when indented
    " smartindent automatically indents/outdents
    " perl_fold automatically folds code between braces

    " Required:
    autocmd FileType perl set tabstop=2 shiftwidth=2 expandtab softtabstop=2
    
    " Optional:
    autocmd FileType perl set autoindent smartindent
    autocmd FileType perl set showmatch
    autocmd FileType perl set number
    let perl_fold=1 " needs fold options above

*emacs:*

We aren't dirty hippies, so we don't use emacs.

### Block Braces: ###

Do use a style similar to K&R style, not the same. The following example is the best guide:

*Do:*
```perl
    sub foo {

       my ($self, $cond, $baz, $taz) = @_;

       if ($cond) {
           bar();
       } else {
           $self->foo("one", 2, "...");
       }
  
       return $self;
    }
```
*Do not:*
```perl
    sub foo
    {
       my ($self,$bar,$baz,$taz)=@_;
       if( $cond )
       {
           &bar();
       }
       else { $self->foo ("one",2,"..."); }
       return $self;
    }
```
### Lists and Arrays: ###

Whenever you create a list or an array, always add a comma after the last item. The reason for doing this is that it's highly probable that new items will be appended to the end of the list in the future. If the comma is missing and this isn't noticed, there will be an error.

*Do:*

```perl
    my @list = (
        "item1",
        "item2",
        "item3",
    );
```

*Do not:*

```perl
    my @list = (
        "item1",
        "item2",
        "item3"
    );
```

**Last Statement in the Block**

The same goes for `;` in the last statement of the block. Almost always add it even if it's not required, so when you add a new statement you don't have to remember to add `;` on a previous line.

*Do:*

```perl
    sub foo {
        statement1;
        statement2;
        statement3;
    }
```

*Do not:*

```perl
    sub foo {
        statement1;
        statement2;
        statement3
    }
```

### Calling system: ###

Try not to use system commands where Perl provides a solution either via a built-in or a module.

### Visual elements: ###

Line up corresponding things vertically.

*Example:*

```perl
    do_this_thing_here or die "can't do this thing: "     . $!;
    do_something_else  or die "can't do something else: " . $!;
    do_whatever        or die "can't do whatever: "       . $!;
```

### Error handling with die() ###

Do not put \n in die() messages.  It removes useful file/line info that otherwise would normally be printed.

*Example:*

```perl
    $ perl -e 'die("I died")'
    I died at -e line 1.
```

v.s.

```perl
    $ perl -e 'die("I died\n")'
    I died
```


### Printing to wherever: ###

Use `print<<__TOHERE;` with `__TOHERE` instead of repeated `print` statements.

*Do:*

```perl
    print<<__TOHERE;
    The stuff I want to print
    All goes inside
    this block
    __TOHERE
```

*Do not:*

```perl
    print "The stuff I want to print\n";
    print "All goes inside\n";
    print "this block\n";
```

Try to use the `. "\n"` where a newline is needed in a `print` statement. Do not put `$variables` inside quotes for printing. For example:

*Do:*

```perl
    print "My variable is: " . $variable . "\n";
```

*Do not:*

```perl
    print "My variable is: $variable\n";
```

Where output formatting is required, try to use a template for the output. Thus, if changes are required they need only be made to the template.

### Looping: ###

In loops, try to use `last` to exit the loop. Try to use `for` and `foreach` instead of `map` if it is more readable to do so.

*Example:*

```perl
    foreach my $line(@file) {
        do things;
        last $line if $something;
        next $line if $somethingelse;
        do other things;
    }
```

### Parentheses: ###

Use parens, even if they are not needed. For example:

*Do:*

```perl
    print(reverse (sort num(values(%hash))));
```

*Do not:*

```perl
    print reverse sort num values %hash;
```

### Subroutines: ###

* **MUST** come at the end of the script
* **MUST** have a descriptive name
* **MUST** have a description of what is going on
* **MUST** return something.

### End of all code: ###

**MUST** have `__END__` after the end of all code that is executed. The POD starts after this.

### Code cleansing: ###

When the code is ready for public consumption, perltidy should be used to clean up formatting, any commented lines of code and any unused code **MUST** be removed.

### Commenting: ###

Is a good thing&trade;. Clearly commented code is easy to work on, easy to trouble shoot and easy to maintain. Use comments.

Srsly, use comments.

### Modifications: ###

For code that is under development and in a developers home CVS/SVN/git store, provide patches to that developer for any changes you wish to make. The developer should then assess the patch and apply it or modify their code to achieve the results wanted.

For code that is being used, make a copy of the code to make changes on.  Test your changes and if the script functions correctly after the changes have been made, make the changes to the script in CVS/SVN/git and commit those changes. All code changes must be accompanied by an explanation in the CVS/SVN/git commit message and any functional changes in the code must be clearly commented.

---

### PerlTidy ###

**Do** use it.

[Perltidy RC for Download][]

  
    # Perltidy config file
    # 
    # Usage:
    # Copy to ~/.perltidyrc
    #
    # $Id: coding-style-Perl.txt 505 2013-03-01 19:38:45Z nhoughton $
    #
  
    # no line wrap
    -l=0
    # Indent level should be two columns
    -i=2
    # opening braces right
    -bar
    # Do not put braces on a new line
    -nbl
    # Except for sub routines
    -nsbl
  
    # Styles for non-block containers
    -lp    # <- this is pretty but not so great for deep structures, needs some testing to decide on preference
    -vt=1  # <- new line for anything coming after a paren, used with -lp option above
    -cti=1 # <- line up closing paren with the opener, better option when using -lp
    -vtc=1 # <- line up closing bracket with closing paren, vertical alignment, looks better when using -cti
  
    # tighten up containers
    -pt=2 # <- tighten up horizontal space within set of container tokens, default is -pt=1
    # Example:
    # if ((my $foo = length($bar)) > 0) { ...
    -sbt=2 # <- same as -pt but for sqare parens
    # Example:
    # $foo = $bar[$i + $j] - $bar[$i];
    -bt=2  # <- same as -pt but for curly braces
    # Example:
    # $obj->{$did_stuff->{'foo'}[0]};
    -bbt=2 # <- same as -pt but for code block curly braces
    # Example:
    # %foo = map{$_ => $bar} grep {baz} join ',';
  
    # Function names and parens
    # default value is no-space
    # myfunc( $a, $b, $c );
  
    # Perl keywords and parens
    # default value is no-space
    # $a = pop(@b);
  
    # Statement termination
    # default is no-space
    # $i = 1;
  
    # For-loop semicolons
    -nsfs # <- no spaces between items and their semi-colons
    # Example:
    # for ( @a = foo; @b = bar; ) { ...
  
    # Do not outdent long lines
    -nolq # <- stops long lines being automatically placed back at the left

This rc file is available from SVN.

---

## REQUIRED ELEMENTS ##

---

Most of what we write is done in Perl, so first up, here is what should
be in all Perl scripts:

    #!/usr/bin/env perl
    #
    # File name: some_perl_script.pl
    # Date:      YYYY/mm/dd HH:MM
    # Author:    First Last <email@yourdomain.com>
    # $Id: $
    # Copyright: (c) Something Here. YYYY
    #
    ######################################################################
    #

    use strict;
    use warnings;
  
  
    __END__

    =head1 POD starts here with the script name

    =head1 DESCRIPTION

    Description of what this file is used for and what it produces.

    =head1 USAGE

    Usage description.

    =head1 AUTHOR

    The person to blame.

    =head1 COPYRIGHT

    Sourcefire (c) Inc. YYYY

That's the bare outline for a Perl script. This can be used as a skeleton template that will auto-populate most of the information from shell environment variables.

To use the skeleton plugin, the following must be present in your `.vimrc`

    so ~/.vim/macros/skeletons.vim

The `skeletons.vim` macro must be in `~/.vim/macros/`, the skeleton templates are expected to be in `~/.vim/skeletons/`

In your shell's environment (however you do that for your shell, in zsh
you might use a .zshenv sourced from .zshrc), you need the following:

```zsh
VIM_USER_NAME="Your Name <youremail@yourdomain.com>"
export VIM_USER_NAME
VIM_COPYRIGHT="(c) Something here $YDATE"
export VIM_COPYRIGHT
VIM_USER_TITLE="Your Title, If you want"
export VIM_USER_TITLE
VIM_USER_EMAIL="<youremail@yourdomain.com>"
export VIM_USER_EMAIL
VIM_DATE=`date +"%B %Y"`
export VIM_DATE
```

[Vim RC file for Download](https://github.com/EnglishLFC/PerlStuff/blob/master/vimrc)

[Perltidy RC for Download](https://github.com/EnglishLFC/PerlStuff/blob/master/perltidyrc)

[Skeleton Template File for Download](https://github.com/EnglishLFC/PerlStuff/blob/master/default.pl)


