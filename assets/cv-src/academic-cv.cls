%-------------------------------------------------------------------------------
%                ACADEMIC CV - Custom LaTeX Class File
%-------------------------------------------------------------------------------
%
% A classic academic CV in Computer Modern: dates and labels in a narrow left
% column, content in the right column, plain uppercase section headings over a
% full-width rule, no color. Version 9.0.
%
%-------------------------------------------------------------------------------

%----- IDENTIFICATION ----------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{academic-cv}[2026/10/12 v9.0 Academic CV Class]

%----- BASE CLASS --------------------------------------------------------------
\LoadClass[10pt, letterpaper]{article}

%----- REQUIRED PACKAGES -------------------------------------------------------
\usepackage[T1]{fontenc}
\usepackage[english]{babel}
\usepackage{lmodern}  % Latin Modern: the classic LaTeX (Computer Modern) face
\usepackage{microtype}
\usepackage{geometry}
\usepackage{xcolor}
\usepackage{hyperref}
\usepackage{titlesec}
\usepackage{enumitem}
\usepackage{needspace}  % keep section headings with their content across page breaks
\usepackage{tabularx}
\usepackage{fancyhdr}
\usepackage{lastpage}

%----- GEOMETRY & LAYOUT -------------------------------------------------------
\geometry{
  letterpaper,
  left=0.75in,
  right=0.75in,
  top=0.6in,
  bottom=0.85in,
  footskip=0.4in
}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}
\raggedbottom

%----- COLORS ------------------------------------------------------------------
\definecolor{accent}{HTML}{000000}
\definecolor{graytext}{HTML}{4D4D4D}
\definecolor{rulecolor}{HTML}{000000}

\hypersetup{
  colorlinks=true,
  urlcolor=accent,
  linkcolor=accent,
  citecolor=accent,
  pdfauthor={Showkot Hossain},
  pdftitle={Showkot Hossain - Curriculum Vitae},
}

%----- HEADER COMMANDS ---------------------------------------------------------
\newcommand{\cvname}[1]{\def\@cvname{#1}}
\newcommand{\cvposition}[1]{\def\@cvposition{#1}}
\newcommand{\cvaddress}[1]{\def\@cvaddress{#1}}
\newcommand{\cvemail}[1]{\def\@cvemail{#1}}
\newcommand{\cvphone}[1]{\def\@cvphone{#1}}
\newcommand{\cvsite}[1]{\def\@cvsite{#1}}
\newcommand{\cvgithub}[1]{\def\@cvgithub{#1}}
\newcommand{\cvlinkedin}[1]{\def\@cvlinkedin{#1}}
\newcommand{\cvscholar}[1]{\def\@cvscholar{#1}}
\newcommand{\cvresearchgate}[1]{\def\@cvresearchgate{#1}}
\newcommand{\footerdate}[1]{\def\@footerdate{#1}}

\newcommand{\cvsep}{\enspace{\color{rulecolor}\textbar}\enspace}

\newcommand{\makecvheader}{%
  \begin{center}
    {\fontsize{24}{28}\selectfont\scshape\color{accent}\@cvname}\par
    \vspace{3pt}
    {\@cvposition}\par
    \vspace{5pt}
    {\small
      \@cvaddress\cvsep\@cvphone\cvsep\href{mailto:\@cvemail}{\@cvemail}\par
      \vspace{1pt}
      \href{https://\@cvsite}{\@cvsite}\cvsep
      \href{https://scholar.google.com/citations?user=\@cvscholar}{Google Scholar}\cvsep
      \href{https://github.com/\@cvgithub}{GitHub}\cvsep
      \href{https://www.linkedin.com/\@cvlinkedin}{LinkedIn}\cvsep
      \href{\@cvresearchgate}{ResearchGate}\par}
  \end{center}
  \vspace{-4pt}
}

%----- FOOTER ------------------------------------------------------------------
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\fancyfoot[L]{\footnotesize\color{graytext}\@cvname}
\fancyfoot[C]{\footnotesize\color{graytext}Updated \@footerdate}
\fancyfoot[R]{\footnotesize\color{graytext}\thepage\ of \pageref*{LastPage}}

%----- SECTION STYLING ---------------------------------------------------------
% Plain uppercase heading over a full-width rule.
\titleformat{\section}
  {\normalfont\large}
  {}
  {0em}
  {\MakeUppercase}
  [\vspace{0.3ex}\titlerule]
\titlespacing*{\section}{0pt}{2ex plus 0.3ex minus 0.2ex}{0.9ex}

% Never strand a heading at the bottom of a page.
\let\cv@origsection\section
\renewcommand{\section}{\Needspace{5\baselineskip}\cv@origsection}

% A run-in italic label for grouping inside a section (e.g. journal papers).
\newcommand{\cvsubsection}[1]{%
  \Needspace{4\baselineskip}%
  \vspace{0.6ex}{\itshape\color{accent}#1}\par\vspace{0.3ex}}

%----- TWO-COLUMN LIST ---------------------------------------------------------
% Every section is a list whose item labels (dates, [C1], categories) sit in a
% fixed left column. Labels may break onto a second line.
\newlength{\cvleftwidth}
\setlength{\cvleftwidth}{0.82in}
\newlength{\cvgutter}
\setlength{\cvgutter}{0.15in}
\newlength{\cvitemsep}
\setlength{\cvitemsep}{0.5ex}

% \leavevmode before \color: a color special at the very top of the parbox
% would otherwise become its first line and break [t] baseline alignment.
% Zero depth lets a two-line date hang beside the entry instead of pushing
% the entry's second line down.
\newcommand{\cv@label}[1]{%
  \raisebox{0pt}[\height][0pt]{%
    \parbox[t]{\labelwidth}{\raggedright\small\leavevmode\color{graytext}#1}}}

\newenvironment{cvlist}{%
  \begin{list}{}{%
    \setlength{\leftmargin}{\cvleftwidth}%
    \setlength{\labelsep}{\cvgutter}%
    \setlength{\labelwidth}{\cvleftwidth}%
    \addtolength{\labelwidth}{-\cvgutter}%
    \setlength{\itemindent}{0pt}%
    \setlength{\topsep}{0.2ex}%
    \setlength{\partopsep}{0pt}%
    \setlength{\itemsep}{\cvitemsep}%
    \setlength{\parsep}{0pt}%
    \renewcommand{\makelabel}[1]{\cv@label{##1}\hfil}}%
  \raggedright
}{\end{list}}

% \cvitem{left label}{body}
\newcommand{\cvitem}[2]{\item[{#1}]#2}

% \cventry{dates}{role}{organization}{location}: role, organization, and
% location on one line. Follow with \cvdetail or cvbullets as needed. The
% location never splits: when the line is full it moves, whole and still
% right-aligned, to the next line (the TeXbook's trick for a right-aligned
% final item).
\newcommand{\cventry}[4]{%
  \Needspace{3\baselineskip}%
  \item[{#1}]\textbf{#2}, \textit{#3}\unskip
  \nobreak\hfil\penalty50\hskip1em\hbox{}\nobreak\hfill
  \mbox{\small\itshape\color{graytext}#4}{\parfillskip=0pt\par}}

% A plain extra line under an entry (advisor, GPA, ...).
\newcommand{\cvdetail}[1]{{#1}\par}

\newenvironment{cvbullets}{%
  \begin{itemize}[leftmargin=1.1em, label={\small\textbullet}, itemsep=0.2ex, topsep=0.2ex, parsep=0pt, partopsep=0pt]%
}{\end{itemize}}

%----- PUBLICATIONS ------------------------------------------------------------
% \cvpub[short venue]{label}{title}{authors}{venue}: authors, then the title in
% bold quotes, then the venue, run on as one paragraph. The short venue is only
% used by the resume's compact list.
\newcommand{\cvpub}[5][]{%
  \Needspace{3\baselineskip}%
  \item[{#2}]#4. \textbf{``#3''}. \textit{#5}.\par}

% Resume variant: one entry per paper, "[C3] Title. Short venue." Use inside
% a group so the CV's definitions are untouched.
\newcommand{\cv@compactpub}[5][]{\item[{#2}]#3.\ {\itshape #1}.}
\newcommand{\usecompactpublications}{%
  \renewcommand{\cvsubsection}[1]{}%
  \let\cvpub\cv@compactpub
  \setlength{\cvleftwidth}{0.4in}%
  \setlength{\cvgutter}{0.08in}%
  \setlength{\cvitemsep}{0.1ex}}

%----- RESUME ENTRIES ----------------------------------------------------------
% \resentry{role}{organization}{location}{dates}: the industry convention, with
% dates right-aligned and no left column, so the page keeps its full width.
\newcommand{\resentry}[4]{%
  \Needspace{3\baselineskip}%
  \vspace{0.3ex}%
  \textbf{#1}\hfill{\small\color{graytext}#4}\par
  \textit{#2}\hfill{\small\itshape\color{graytext}#3}\par}

\newenvironment{resbullets}{%
  \begin{itemize}[leftmargin=1.1em, label={\small\textbullet}, itemsep=0pt, topsep=0.1ex, parsep=0pt, partopsep=0pt]%
}{\end{itemize}}

% \resline{label}{content}: a bold run-in label, for skills and similar lists.
\newcommand{\resline}[2]{\textbf{#1:} #2\par}

%----- REFERENCES --------------------------------------------------------------
\newenvironment{cvreferences}{%
  \vspace{0.4ex}%
  \tabularx{\textwidth}{@{}X X@{}}%
}{\endtabularx}

\endinput
%----- END OF CLASS FILE -------------------------------------------------------
