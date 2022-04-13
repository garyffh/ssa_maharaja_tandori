const String quillCss='''
<head><style>
p,
ol,
ul,
pre,
blockquote,
h1,
h2,
h3,
h4,
h5,
h6 {
    margin: 0;
    padding: 0;
    counter-reset: list-1 list-2 list-3 list-4 list-5 list-6 list-7 list-8 list-9;
}
ol,
ul {
    padding-left: 1.5em;
}
ol > li,
ul > li {
    list-style-type: none;
}
ul > li::before {
    content: "\u2022";
}

li::before {
    display: inline-block;
    white-space: nowrap;
    width: 1.2em;
}
li:not(.ql-direction-rtl)::before {
    margin-left: -1.5em;
    margin-right: 0.3em;
    text-align: right;
}
li.ql-direction-rtl::before {
    margin-left: 0.3em;
    margin-right: -1.5em;
}
ol li:not(.ql-direction-rtl),
ul li:not(.ql-direction-rtl) {
    padding-left: 1.5em;
}
ol li.ql-direction-rtl,
ul li.ql-direction-rtl {
    padding-right: 1.5em;
}
ol li {
    counter-reset: list-1 list-2 list-3 list-4 list-5 list-6 list-7 list-8 list-9;
    counter-increment: list-0;
}
ol li:before {
    content: counter(list-0, decimal) ". ";
}
ol li.ql-indent-1 {
    counter-increment: list-1;
}
ol li.ql-indent-1:before {
    content: counter(list-1, lower-alpha) ". ";
}
ol li.ql-indent-1 {
    counter-reset: list-2 list-3 list-4 list-5 list-6 list-7 list-8 list-9;
}
ol li.ql-indent-2 {
    counter-increment: list-2;
}
ol li.ql-indent-2:before {
    content: counter(list-2, lower-roman) ". ";
}
ol li.ql-indent-2 {
    counter-reset: list-3 list-4 list-5 list-6 list-7 list-8 list-9;
}
ol li.ql-indent-3 {
    counter-increment: list-3;
}
ol li.ql-indent-3:before {
    content: counter(list-3, decimal) ". ";
}
ol li.ql-indent-3 {
    counter-reset: list-4 list-5 list-6 list-7 list-8 list-9;
}
ol li.ql-indent-4 {
    counter-increment: list-4;
}
ol li.ql-indent-4:before {
    content: counter(list-4, lower-alpha) ". ";
}
ol li.ql-indent-4 {
    counter-reset: list-5 list-6 list-7 list-8 list-9;
}
ol li.ql-indent-5 {
    counter-increment: list-5;
}
ol li.ql-indent-5:before {
    content: counter(list-5, lower-roman) ". ";
}
ol li.ql-indent-5 {
    counter-reset: list-6 list-7 list-8 list-9;
}
ol li.ql-indent-6 {
    counter-increment: list-6;
}
ol li.ql-indent-6:before {
    content: counter(list-6, decimal) ". ";
}
ol li.ql-indent-6 {
    counter-reset: list-7 list-8 list-9;
}
ol li.ql-indent-7 {
    counter-increment: list-7;
}
ol li.ql-indent-7:before {
    content: counter(list-7, lower-alpha) ". ";
}
ol li.ql-indent-7 {
    counter-reset: list-8 list-9;
}
ol li.ql-indent-8 {
    counter-increment: list-8;
}
ol li.ql-indent-8:before {
    content: counter(list-8, lower-roman) ". ";
}
ol li.ql-indent-8 {
    counter-reset: list-9;
}
ol li.ql-indent-9 {
    counter-increment: list-9;
}
ol li.ql-indent-9:before {
    content: counter(list-9, decimal) ". ";
}
.ql-indent-1:not(.ql-direction-rtl) {
    padding-left: 3em;
}
li.ql-indent-1:not(.ql-direction-rtl) {
    padding-left: 4.5em;
}
.ql-indent-1.ql-direction-rtl.ql-align-right {
    padding-right: 3em;
}
li.ql-indent-1.ql-direction-rtl.ql-align-right {
    padding-right: 4.5em;
}
.ql-indent-2:not(.ql-direction-rtl) {
    padding-left: 6em;
}
li.ql-indent-2:not(.ql-direction-rtl) {
    padding-left: 7.5em;
}
.ql-indent-2.ql-direction-rtl.ql-align-right {
    padding-right: 6em;
}
li.ql-indent-2.ql-direction-rtl.ql-align-right {
    padding-right: 7.5em;
}
.ql-indent-3:not(.ql-direction-rtl) {
    padding-left: 9em;
}
li.ql-indent-3:not(.ql-direction-rtl) {
    padding-left: 10.5em;
}
.ql-indent-3.ql-direction-rtl.ql-align-right {
    padding-right: 9em;
}
li.ql-indent-3.ql-direction-rtl.ql-align-right {
    padding-right: 10.5em;
}
.ql-indent-4:not(.ql-direction-rtl) {
    padding-left: 12em;
}
li.ql-indent-4:not(.ql-direction-rtl) {
    padding-left: 13.5em;
}
.ql-indent-4.ql-direction-rtl.ql-align-right {
    padding-right: 12em;
}
li.ql-indent-4.ql-direction-rtl.ql-align-right {
    padding-right: 13.5em;
}
.ql-indent-5:not(.ql-direction-rtl) {
    padding-left: 15em;
}
li.ql-indent-5:not(.ql-direction-rtl) {
    padding-left: 16.5em;
}
.ql-indent-5.ql-direction-rtl.ql-align-right {
    padding-right: 15em;
}
li.ql-indent-5.ql-direction-rtl.ql-align-right {
    padding-right: 16.5em;
}
.ql-indent-6:not(.ql-direction-rtl) {
    padding-left: 18em;
}
li.ql-indent-6:not(.ql-direction-rtl) {
    padding-left: 19.5em;
}
.ql-indent-6.ql-direction-rtl.ql-align-right {
    padding-right: 18em;
}
li.ql-indent-6.ql-direction-rtl.ql-align-right {
    padding-right: 19.5em;
}
.ql-indent-7:not(.ql-direction-rtl) {
    padding-left: 21em;
}
li.ql-indent-7:not(.ql-direction-rtl) {
    padding-left: 22.5em;
}
.ql-indent-7.ql-direction-rtl.ql-align-right {
    padding-right: 21em;
}
li.ql-indent-7.ql-direction-rtl.ql-align-right {
    padding-right: 22.5em;
}
.ql-indent-8:not(.ql-direction-rtl) {
    padding-left: 24em;
}
li.ql-indent-8:not(.ql-direction-rtl) {
    padding-left: 25.5em;
}
.ql-indent-8.ql-direction-rtl.ql-align-right {
    padding-right: 24em;
}
li.ql-indent-8.ql-direction-rtl.ql-align-right {
    padding-right: 25.5em;
}
.ql-indent-9:not(.ql-direction-rtl) {
    padding-left: 27em;
}
li.ql-indent-9:not(.ql-direction-rtl) {
    padding-left: 28.5em;
}
.ql-indent-9.ql-direction-rtl.ql-align-right {
    padding-right: 27em;
}
li.ql-indent-9.ql-direction-rtl.ql-align-right {
    padding-right: 28.5em;
}
.ql-video {
    display: block;
    max-width: 100%;
}
.ql-video.ql-align-center {
    margin: 0 auto;
}
.ql-video.ql-align-right {
    margin: 0 0 0 auto;
}
.ql-bg-black {
    background-color: #000;
}
.ql-bg-red {
    background-color: #e60000;
}
.ql-bg-orange {
    background-color: #f90;
}
.ql-bg-yellow {
    background-color: #ff0;
}
.ql-bg-green {
    background-color: #008a00;
}
.ql-bg-blue {
    background-color: #06c;
}
.ql-bg-purple {
    background-color: #93f;
}
.ql-color-white {
    color: #fff;
}
.ql-color-red {
    color: #e60000;
}
.ql-color-orange {
    color: #f90;
}
.ql-color-yellow {
    color: #ff0;
}
.ql-color-green {
    color: #008a00;
}
.ql-color-blue {
    color: #06c;
}
.ql-color-purple {
    color: #93f;
}
.ql-font-serif {
    font-family: Georgia, Times New Roman, serif;
}
.ql-font-monospace {
    font-family: Monaco, Courier New, monospace;
}
.ql-size-small {
    font-size: 0.75em;
}
.ql-size-large {
    font-size: 1.5em;
}
.ql-size-huge {
    font-size: 2.5em;
}
.ql-direction-rtl {
    direction: rtl;
    text-align: inherit;
}
.ql-align-center {
    text-align: center;
}
.ql-align-justify {
    text-align: justify;
}
.ql-align-right {
    text-align: right;
}
.ql-blank::before {
    color: rgba(0,0,0,0.6);
    content: attr(data-placeholder);
    font-style: italic;
    left: 15px;
    pointer-events: none;
    position: absolute;
    right: 15px;
}
</style></head>
''';

