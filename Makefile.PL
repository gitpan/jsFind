use 5.005;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'jsFind',
    VERSION_FROM      => 'jsFind.pm', # finds $VERSION
    PREREQ_PM         => {
	'Carp' => 0,
	'File::Path' => 0,
    	'HTML::Entities' => 0,
	'Text::Iconv' => 0,
    },
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'jsFind.pm', # retrieve abstract from module
       AUTHOR         => 'Dobrica Pavlinusic <dpavlin@rot13.org>') : ()),
);

# new target to create png files from GraphViz's dot files created by test

sub MY::postamble {
	return <<'MAKE_MORE';
#png: tree.png words.png
png: tree.png

tree.png: tree.dot
	dot -Tpng -o tree.png tree.dot

#words.png: words.dot
#	dot -Tpng -o words.png words.dot

html: blib/lib/jsFind.pm all
	pod2html blib/lib/jsFind.pm jsFind.html

clean ::
	rm tree.* words.*
	cd html && rm -Rf entities entities-utf8/ lorem/ words/

MAKE_MORE
}
