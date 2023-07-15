import { Link } from '@chakra-ui/react'

export default function NavBar() {
    return <nav className="nav">
        <Link href="/" className="site-title">Simple Language Learning</Link>
        <ul>
            <li>
                <Link href="/nouns" className="site-links">Nouns</Link>
            </li>
            <li>
                <Link href="/verbs" className="site-links">Verbs</Link>
            </li>
            <li>
                <Link href="/adjectives" className="site-links">Adjectives</Link>
            </li>
            <li>
                <Link href="/adverbs" className="site-links">Adverbs</Link>
            </li>
            <li>
                <Link href="/other" className="site-links">Other</Link>
            </li>
        </ul>
    </nav>
}