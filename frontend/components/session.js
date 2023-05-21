import React, { useEffect, useState } from 'react';

export default function Session() {
    // states
    const [answer, setAnswer] = useState('')

    // functions

    // html
    return (
        <div>
            <div>What is the Italian translation of: To go</div>
            <input
                placeholder='type answer here'
                required
                value={answer}
                onChange={(e) => setAnswer(e.target.value)}
            ></input>
            <button onClick={}>Submit</button>
        </div>

    )
}