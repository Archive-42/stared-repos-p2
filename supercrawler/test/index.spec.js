var proxyquire = require('proxyquire'),
    expect = require("chai").expect,
    CrawlerMock,
    UrlMock,
    DbUrlListMock,
    htmlLinkParserMock,
    robotsParserMock,
    sitemapsParserMock,
    index;

CrawlerMock = function () {};
UrlMock = function () {};
DbUrlListMock = function () {};
htmlLinkParserMock = function () {};
robotsParserMock = function () {};
sitemapsParserMock = function () {};

index = proxyquire("../lib/index", {
  "./Crawler": CrawlerMock,
  "./Url": UrlMock,
  "./DbUrlList": DbUrlListMock,
  "./handlers/htmlLinkParser": htmlLinkParserMock,
  "./handlers/robotsParser": robotsParserMock,
  "./handlers/sitemapsParser": sitemapsParserMock
});

describe("index", function () {
  it("exposes Crawler", function () {
    expect(index.Crawler).to.equal(CrawlerMock);
  });

  it("exposes Url", function () {
    expect(index.Url).to.equal(UrlMock);
  });

  it("exposes DbUrlList", function () {
    expect(index.DbUrlList).to.equal(DbUrlListMock);
  });

  it("exposes htmlLinkParser", function () {
    expect(index.handlers.htmlLinkParser).to.equal(htmlLinkParserMock);
  });

  it("exposes robotsParser", function () {
    expect(index.handlers.robotsParser).to.equal(robotsParserMock);
  });

  it("exposes sitemapsParser", function () {
    expect(index.handlers.sitemapsParser).to.equal(sitemapsParserMock);
  });
});
