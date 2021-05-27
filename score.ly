\version "2.20.0"

\include "makeOctaves.ly"
\include "definitions.ly"
\include "rh.ly"
\include "lh.ly"
\include "melody.ly"
\include "chords.ly"

\header {
  title = "林家謙 - 時光倒流一句話"
  subtitle = "Voice with Piano Accompaniment"
  composer = "林家謙"
  arranger = "Arranged by Benson"
}

global-tempo = {
  \tempo 4 = 82
}
global = {
  \key d \major
}

rh = \relative c' {
  \clef bass
  \metronomePaddingA
  \tag #'mini { \metronomePaddingB }
  \global-tempo
  \global
  \rh-intro
  \rh-verse-A
  \rh-chorus-A
  \rh-episode-A
  \rh-verse-B
  \rh-chorus-B
  \rh-episode-B
  \rh-bridge
  \rh-chorus-C
  \rh-outro
  \bar "|."
}

lh = \relative c {
  \clef bass
  \global
  \lh-intro
  \lh-verse-A
  \lh-chorus-A
  \lh-episode-A
  \lh-verse-B
  \lh-chorus-B
  \lh-episode-B
  \lh-bridge
  \lh-chorus-C
  \lh-outro
  \bar "|."
}

melody = \relative c' {
  \global
  \clef treble
  \melody-full
}

dynamics = {
  % intro

  % verse-A

  % chorus A

  % episode A

  % verse-B

  % chorus B

  % episode B

  % bridge

  % chorus C

  % outro
}

\paper {
  page-breaking = #ly:page-turn-breaking
  oddFooterMarkup = \markup {
    \fill-line {
      "https://music.bensonby.me"
    }
  }
  evenFooterMarkup = \oddFooterMarkup
  footnote-footer-padding = 4.5\mm
  last-bottom-spacing.basic-distance = #11
}
\score {
  <<
    \new ChordNames {
      \chords-full
    }
    \new Staff = "melodystaff" \with {
      fontSize = #-3
      \override StaffSymbol.staff-space = #(magstep -3)
      \override StaffSymbol.thickness = #(magstep -3)
    } <<
      \set Staff.instrumentName = #"Vocal"
      \set Staff.midiInstrument = #"oboe"
      \set Staff.midiMinimumVolume = #0.9
      \set Staff.midiMaximumVolume = #1
      \new Voice = "melody" {
        \melody
      }
      \context Lyrics = "lyrics" { \lyricsto "melody" { \lyricsmain } }
    >>
    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Piano"
      \new Staff = "right" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.6
        \set Staff.midiMaximumVolume = #0.7
        \removeWithTag #'mini \rh
      }
      \new Dynamics = "Dynamics_pf" \removeWithTag #'mini \dynamics
      \new Staff = "left" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.6
        \set Staff.midiMaximumVolume = #0.7
        \removeWithTag #'mini \lh
      }
    >>
  >>
  \layout {
    \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      \Staff \RemoveEmptyStaves
    }
    \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      % \Dynamics \RemoveEmptyStaves
    }
    \context {
      \Score
      % Remove all-rest staves also in the first system
      % \override VerticalAxisGroup.remove-first = ##t
      % If only one non-empty staff in a system exists, still print the starting bar
      % \override SystemStartBar.collapse-height = #1
    }
    \context {
      \ChordNames
      \override ChordName #'font-size = #-1
    }
    \context {
      \Lyrics
      \override LyricText.font-name = #"Noto Sans CJK TC"
      \override LyricText.font-size = #-1
    }
  }
  \midi {
    \context {
      % \ChordNameVoice \remove Note_performer
    }
  }
}

\book {
  \bookOutputSuffix "mini"
  #(set! paper-alist (cons '("snippet" . (cons (* 200 mm) (* 50 mm))) paper-alist))
  \header {
    piece = "林家謙 - 時光倒流一句話"
    opus = "Arranged by Benson"
    title = ""
    subtitle = ""
    subsubtitle = ""
    composer = ""
    arranger = ""
  }
  \paper {
    #(set-paper-size "snippet")
    indent = 0
    tagline = ##f
    print-all-headers = ##f
    evenHeaderMarkup = ##f
    oddHeaderMarkup = ##f
    evenFooterMarkup = ##f
    oddFooterMarkup = ##f
    % top-margin = 1\mm
    top-markup-spacing.basic-distance = #1 %-dist. from bottom of top margin to the first markup/title
    markup-system-spacing.basic-distance = #2 %-dist. from header/title to first system
    top-system-spacing.basic-distance = #0.6 %-dist. from top margin to system in pages with no titles
    system-system-spacing.basic-distance = #1 %-dist. from top margin to system in pages with no titles
    last-bottom-spacing.basic-distance = #0.3 %-pads music from copyright block
  }

  \score {
    \new StaffGroup <<
      \new ChordNames {
        \chords-full
      }
      \new Staff = "melodystaff" \with {
        fontSize = #-3
        \override StaffSymbol.staff-space = #(magstep -3)
        \override StaffSymbol.thickness = #(magstep -3)
      } <<
        \set Staff.instrumentName = #"Vocal"
        \set Staff.midiInstrument = #"oboe"
        \set Staff.midiMinimumVolume = #0.9
        \set Staff.midiMaximumVolume = #1
        \new Voice = "melody" {
          \melody
        }
        \context Lyrics = "lyrics" { \lyricsto "melody" { \lyricsmain } }
      >>
      \new PianoStaff <<
        \new Staff = "right" { \keepWithTag #'mini \rh }
        \new Dynamics = "dynamics" { \keepWithTag #'mini \dynamics }
        \new Staff = "left" { \keepWithTag #'mini \lh }
      >>
    >>
    \layout {
      #(layout-set-staff-size 15)
      \context {
        % add the RemoveEmptyStaffContext that erases rest-only staves
        \Staff \RemoveEmptyStaves
      }
      \context {
        \Score
        % Remove all-rest staves also in the first system
        \override VerticalAxisGroup.remove-first = ##t
      }
      \context {
        \Voice
        % \override Script.stencil = #bold-tenuto-script-stencil
      }
      \context {
        \ChordNames
        \override ChordName #'font-size = #0
      }
      \context {
        \Lyrics
        \override LyricText.font-name = #"Noto Sans CJK TC"
        \override LyricText.font-size = #0
      }
    }
  }
}
