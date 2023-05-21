import React, { useEffect, useState } from 'react';
import NavBar from '../components/navbar';

// variables
let ignore = false

// main component
export default function HomePage() {
  
  // states

  // html

  return (
    
    <div>
      <NavBar></NavBar>
      <br />
      <div>The aim of this project is to create a website where you can practice vocab learning in a foreign language</div> <br />
      <div>Currently, the only supported language is Italian</div> <br />
      <div>Words are taken from 
        {" "}  
         <a href="https://www.fluentin3months.com/italian-words/#h-the-100-most-used-italian-nouns-20-more-nouns-you-need-to-know">this website</a>
      </div>
    </div>

  );
}