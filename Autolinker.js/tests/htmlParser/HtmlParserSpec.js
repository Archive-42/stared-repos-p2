/*global Autolinker, _, describe, beforeEach, afterEach, it, expect, jasmine */
describe( "Autolinker.htmlParser.HtmlParser", function() {
	var HtmlParser = Autolinker.htmlParser.HtmlParser,
	    CommentNode = Autolinker.htmlParser.CommentNode,
	    ElementNode = Autolinker.htmlParser.ElementNode,
	    EntityNode = Autolinker.htmlParser.EntityNode,
	    TextNode = Autolinker.htmlParser.TextNode,
	    htmlParser;


	beforeEach( function() {
		htmlParser = new HtmlParser();
	} );


	function expectCommentNode( node, offset, text, comment ) {
		expect( node ).toEqual( jasmine.any( CommentNode ) );
		expect( node.getOffset() ).toBe( offset );
		expect( node.getText() ).toBe( text );
		expect( node.getComment() ).toBe( comment );
	}

	function expectElementNode( node, offset, tagText, tagName, isClosingTag ) {
		expect( node ).toEqual( jasmine.any( ElementNode ) );
		expect( node.getOffset() ).toBe( offset );
		expect( node.getText() ).toBe( tagText );
		expect( node.getTagName() ).toBe( tagName );
		expect( node.isClosing() ).toBe( isClosingTag );
	}

	function expectEntityNode( node, offset, text ) {
		expect( node ).toEqual( jasmine.any( EntityNode ) );
		expect( node.getOffset() ).toBe( offset );
		expect( node.getText() ).toBe( text );
	}

	function expectTextNode( node, offset, text ) {
		expect( node ).toEqual( jasmine.any( TextNode ) );
		expect( node.getOffset() ).toBe( offset );
		expect( node.getText() ).toBe( text );
	}


	it( "should return an empty array for an empty input string", function() {
		expect( htmlParser.parse( "" ) ).toEqual( [] );
	} );


	describe( 'text node handling', function() {

		it( "should return a single text node if there are no HTML nodes in it", function() {
			var nodes = htmlParser.parse( "Testing 123" );

			expect( nodes.length ).toBe( 1 );
			expectTextNode( nodes[ 0 ], 0, 'Testing 123' );
		} );

	} );


	describe( 'HTML comment node handling', function() {

		it( "should return a single comment node if there is only an HTML comment node in it", function() {
			var nodes = htmlParser.parse( "<!-- Testing 123 -->" );

			expect( nodes.length ).toBe( 1 );
			expectCommentNode( nodes[ 0 ], 0, "<!-- Testing 123 -->", "Testing 123" );
		} );


		it( "should handle a multi-line comment, and trim any amount of whitespace in the comment for the comment's text", function() {
			var nodes = htmlParser.parse( "<!-- \n  \t\n Testing 123  \n\t  \n\n -->" );

			expect( nodes.length ).toBe( 1 );
			expectCommentNode( nodes[ 0 ], 0, "<!-- \n  \t\n Testing 123  \n\t  \n\n -->", "Testing 123" );
		} );


		it( "should produce 3 nodes for a text node, comment, then text node", function() {
			var nodes = htmlParser.parse( "Test <!-- Comment --> Test" );

			expect( nodes.length ).toBe( 3 );
			expectTextNode   ( nodes[ 0 ], 0, 'Test ' );
			expectCommentNode( nodes[ 1 ], 5, '<!-- Comment -->', 'Comment' );
			expectTextNode   ( nodes[ 2 ], 21, ' Test' );
		} );


		it( "should produce 4 nodes for a text node, comment, text node, comment", function() {
			var nodes = htmlParser.parse( "Test <!-- Comment --> Test <!-- Comment 2 -->" );

			expect( nodes.length ).toBe( 4 );
			expectTextNode   ( nodes[ 0 ], 0, 'Test ' );
			expectCommentNode( nodes[ 1 ], 5, '<!-- Comment -->', 'Comment' );
			expectTextNode   ( nodes[ 2 ], 21, ' Test ' );
			expectCommentNode( nodes[ 3 ], 27, '<!-- Comment 2 -->', 'Comment 2' );
		} );

	} );


	describe( 'HTML element node handling', function() {

		it( "should return a single element node if there is only an HTML element node in it", function() {
			var nodes = htmlParser.parse( "<div>" );

			expect( nodes.length ).toBe( 1 );
			expectElementNode( nodes[ 0 ], 0, '<div>', 'div', false );
		} );


		it( "should produce 3 nodes for a text node, element, then text node", function() {
			var nodes = htmlParser.parse( "Test <div> Test" );

			expect( nodes.length ).toBe( 3 );
			expectTextNode   ( nodes[ 0 ], 0, 'Test ' );
			expectElementNode( nodes[ 1 ], 5, '<div>', 'div', false );
			expectTextNode   ( nodes[ 2 ], 10, ' Test' );
		} );


		it( "should be able to reproduce the input string based on the text that was provided to each returned `HtmlNode`", function() {
			var inputStr = 'Joe went to <a href="google.com">ebay.com</a> today,&nbsp;and bought <b>big</b> items',
				nodes = htmlParser.parse( inputStr ),
				result = [];

			for( var i = 0, len = nodes.length; i < len; i++ ) {
				result.push( nodes[ i ].getText() );
			}

			expect( result.length ).toBe( 11 );
			expect( result.join( "" ) ).toBe( inputStr );
		} );


		it( "should properly handle tags without attributes", function() {
			var nodes = htmlParser.parse( 'Test1 <div><span>Test2</span> Test3</div>' );

			expect( nodes.length ).toBe( 7 );
			expectTextNode   ( nodes[ 0 ], 0, 'Test1 ' );
			expectElementNode( nodes[ 1 ], 6, '<div>', 'div', false );
			expectElementNode( nodes[ 2 ], 11, '<span>', 'span', false );
			expectTextNode   ( nodes[ 3 ], 17, 'Test2' );
			expectElementNode( nodes[ 4 ], 22, '</span>', 'span', true );
			expectTextNode   ( nodes[ 5 ], 29, ' Test3' );
			expectElementNode( nodes[ 6 ], 35, '</div>', 'div', true );
		} );


		it( "should properly handle a tag where the attributes start on the " +
			"next line",
		function() {
			var nodes = htmlParser.parse( 'Test <div\nclass="myClass"\nstyle="color:red"> Test' );

			expect( nodes.length ).toBe( 3 );
			expectTextNode   ( nodes[ 0 ], 0, 'Test ' );
			expectElementNode( nodes[ 1 ], 5, '<div\nclass="myClass"\nstyle="color:red">', 'div', false );
			expectTextNode   ( nodes[ 2 ], 44, ' Test' );
		} );

	} );


	describe( 'HTML entity handling', function() {

		it( "should *not* match the &amp; HTML entity, as this may be part of a query string", function() {
			var nodes = htmlParser.parse( 'Me&amp;You' );

			expect( nodes.length ).toBe( 1 );
			expectTextNode( nodes[ 0 ], 0, 'Me&amp;You' );
		} );


		it( "should properly parse a string that begins with an HTML entity node", function() {
			var nodes = htmlParser.parse( '&quot;Test' );

			expect( nodes.length ).toBe( 2 );
			expectEntityNode( nodes[ 0 ], 0, '&quot;' );
			expectTextNode(   nodes[ 1 ], 6, 'Test' );
		} );


		it( "should properly parse a string that ends with an HTML entity node", function() {
			var nodes = htmlParser.parse( 'Test&quot;' );

			expect( nodes.length ).toBe( 2 );
			expectTextNode(   nodes[ 0 ], 0, 'Test' );
			expectEntityNode( nodes[ 1 ], 4, '&quot;' );
		} );


		it( "should properly parse a string that begins and ends with an HTML entity node", function() {
			var nodes = htmlParser.parse( '&quot;Test&quot;' );

			expect( nodes.length ).toBe( 3 );
			expectEntityNode( nodes[ 0 ], 0,  '&quot;' );
			expectTextNode(   nodes[ 1 ], 6,  'Test' );
			expectEntityNode( nodes[ 2 ], 10, '&quot;' );
		} );


		it( "should properly parse a string that has an HTML entity node in the middle", function() {
			var nodes = htmlParser.parse( 'Test&quot;Test' );

			expect( nodes.length ).toBe( 3 );
			expectTextNode(   nodes[ 0 ], 0,  'Test' );
			expectEntityNode( nodes[ 1 ], 4,  '&quot;' );
			expectTextNode(   nodes[ 2 ], 10, 'Test' );
		} );


		it( "should properly parse a string that only has an HTML entity node", function() {
			var nodes = htmlParser.parse( '&quot;' );

			expect( nodes.length ).toBe( 1 );
			expectEntityNode( nodes[ 0 ], 0, '&quot;' );
		} );

	} );


	describe( 'combination examples', function() {

		it( "should properly create `HtmlNode` instances for each text/entity/comment/element node encountered, with the proper data filled in on each node", function() {
			var inputStr = [
				'&quot;Joe went to &quot;',
				'<a href="google.com">ebay.com</a>&quot; ',
				'today,&nbsp;and <!-- stuff -->bought <b>big</b> items&quot;'
			].join( "" );

			var nodes = htmlParser.parse( inputStr );
			expect( nodes.length ).toBe( 17 );

			var i = -1;
			expectEntityNode ( nodes[ ++i ], 0,   '&quot;' );
			expectTextNode   ( nodes[ ++i ], 6,   'Joe went to ' );
			expectEntityNode ( nodes[ ++i ], 18,  '&quot;' );
			expectElementNode( nodes[ ++i ], 24,  '<a href="google.com">', 'a', false );
			expectTextNode   ( nodes[ ++i ], 45,  'ebay.com' );
			expectElementNode( nodes[ ++i ], 53,  '</a>', 'a', true );
			expectEntityNode ( nodes[ ++i ], 57,  '&quot;' );
			expectTextNode   ( nodes[ ++i ], 63,  ' today,' );
			expectEntityNode ( nodes[ ++i ], 70,  '&nbsp;' );
			expectTextNode   ( nodes[ ++i ], 76,  'and ' );
			expectCommentNode( nodes[ ++i ], 80,  '<!-- stuff -->', 'stuff' );
			expectTextNode   ( nodes[ ++i ], 94,  'bought ' );
			expectElementNode( nodes[ ++i ], 101, '<b>', 'b', false );
			expectTextNode   ( nodes[ ++i ], 104, 'big' );
			expectElementNode( nodes[ ++i ], 107, '</b>', 'b', true );
			expectTextNode   ( nodes[ ++i ], 111, ' items' );
			expectEntityNode ( nodes[ ++i ], 117, '&quot;' );
		} );


		it( 'should match tags of both upper and lower case', function() {
			var inputStr = [
				'Joe <!DOCTYPE html><!-- Comment -->went <!doctype "blah" "blah blah"> ',
				'to <a href="google.com">ebay.com</a> today,&nbsp;and <A href="purchase.com">purchased</A> ',
				'<b>big</b> <B><!-- Comment 2 -->items</B>'
			].join( '' );
			var nodes = htmlParser.parse( inputStr );

			expect( nodes.length ).toBe( 24 );

			var i = -1;
			expectTextNode   ( nodes[ ++i ], 0,   'Joe ' );
			expectElementNode( nodes[ ++i ], 4,   '<!DOCTYPE html>', '!doctype', false );
			expectCommentNode( nodes[ ++i ], 19,  '<!-- Comment -->', 'Comment' );
			expectTextNode   ( nodes[ ++i ], 35,  'went ' );
			expectElementNode( nodes[ ++i ], 40,  '<!doctype "blah" "blah blah">', '!doctype', false );
			expectTextNode   ( nodes[ ++i ], 69,  ' to ' );
			expectElementNode( nodes[ ++i ], 73,  '<a href="google.com">', 'a', false );
			expectTextNode   ( nodes[ ++i ], 94,  'ebay.com' );
			expectElementNode( nodes[ ++i ], 102, '</a>', 'a', true );
			expectTextNode   ( nodes[ ++i ], 106, ' today,' );
			expectEntityNode ( nodes[ ++i ], 113, '&nbsp;' );
			expectTextNode   ( nodes[ ++i ], 119, 'and ' );
			expectElementNode( nodes[ ++i ], 123, '<A href="purchase.com">', 'a', false );
			expectTextNode   ( nodes[ ++i ], 146, 'purchased' );
			expectElementNode( nodes[ ++i ], 155, '</A>', 'a', true );
			expectTextNode   ( nodes[ ++i ], 159, ' ' );
			expectElementNode( nodes[ ++i ], 160, '<b>', 'b', false );
			expectTextNode   ( nodes[ ++i ], 163, 'big' );
			expectElementNode( nodes[ ++i ], 166, '</b>', 'b', true );
			expectTextNode   ( nodes[ ++i ], 170, ' ' );
			expectElementNode( nodes[ ++i ], 171, '<B>', 'b', false );
			expectCommentNode( nodes[ ++i ], 174, '<!-- Comment 2 -->', 'Comment 2' );
			expectTextNode   ( nodes[ ++i ], 192, 'items' );
			expectElementNode( nodes[ ++i ], 197, '</B>', 'b', true );
		} );

	} );


	it( "should not freeze up the regular expression engine when presented with the input string in issue #54", function() {
		var inputStr = "Shai ist endlich in Deutschland! Und wir haben gute Nachrichten! <3 Alle, die den Shai-Rasierer kostenlos probieren, machen am Gewinnspiel eines Jahresvorrates Klingen mit. Den Rasierer bekommst Du kostenlos durch diesen Link: http://dorcoshai.de/pb1205ro, und dann machst Du am Gewinnspiel mit! 'Gefallt mir' klicken, wenn Du gern einen Jahresvorrat Shai haben mochtest. (Y)",
		    nodes = htmlParser.parse( inputStr );

		expect( nodes.length ).toBe( 1 );
		expectTextNode( nodes[ 0 ], 0, inputStr );
	} );


	it( "should not freeze up the regular expression engine when presented with the input string in issue #172", function() {
		var inputStr = '<Office%20days:%20Tue.%20&%20Wed.%20(till%2015:30%20hr),%20Thu.%20(till%2017',//:30%20hr),%20Fri.%20(till%2012:30%20hr).%3c/a%3e%3cbr%3e%3c/td%3e%3ctd%20style=>',
		    nodes = htmlParser.parse( inputStr );

		expect( nodes.length ).toBe( 1 );
		expectTextNode( nodes[ 0 ], 0, inputStr );
	} );

	it( "should not freeze up the regular expression engine when presented with the input string in issue #204", function() {
		var inputStr = '<img src="http://example.com/Foo" border-radius:2px;moz-border-radius:2px;khtml-border-radius:2px;o-border-radius:2px;webkit-border-radius:2px;ms-border-radius:="" 2px; "=" " class=" ">',
		    nodes = htmlParser.parse( inputStr );

		expect( nodes.length ).toBe( 1 );
		expectTextNode( nodes[ 0 ], 0, inputStr );
	} );

} );
