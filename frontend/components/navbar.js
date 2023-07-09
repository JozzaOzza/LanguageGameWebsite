export default function NavBar() {
    return <nav className="nav">
        <a href="/" className="site-title">Simple Language Learning</a>
        <ul>
            <li>
                <a href="/nouns" className="site-links">Nouns</a>
            </li>
            <li>
                <a href="/verbs" className="site-links">Verbs</a>
            </li>
            <li>
                <a href="/adjectives" className="site-links">Adjectives</a>
            </li>
            <li>
                <a href="/adverbs" className="site-links">Adverbs</a>
            </li>
        </ul>
    </nav>
}