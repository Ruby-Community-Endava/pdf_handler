# PDF Handler - PoC
Just a simple PoC exploring different alternatives to manipulate PDF files.

## Libraries

- [qpdf](https://github.com/qpdf/qpdf) for merging.
- [combine_pdf](https://github.com/boazsegev/combine_pdf) for merging.
- [docsplit](https://github.com/documentcloud/docsplit) for splitting.
- [hexapdf](https://github.com/gettalong/hexapdf) for merging/splitting.


## Usage

```
$ bin/console
> PdfHandler::Runner.new.with(:qpdf).perform :merge
> PdfHandler::Runner.new.with(:hexapdf).perform :merge
> PdfHandler::Runner.new.with(:hexapdf).perform :split
> PdfHandler::Runner.new.with(:docsplit).perform :merge
```

output files are located in resources directory, memory reports are located in root directory
